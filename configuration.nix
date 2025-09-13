{ config, pkgs, ... }:
{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  #Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

#---

  #User
  users.users.rory = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "rory";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

#---

  #Programs
  programs.firefox.enable = true;
  programs.steam.enable = true;
  programs.neovim.enable = true;
  programs.git.enable = true;
  programs.zsh = {
    enable = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  programs.zsh.ohMyZsh = {
	enable = true;
	plugins = [ "git" ];
  };


#---

  #Packages
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
  vim
  protonvpn-cli
  wget
  alacritty
  ncdu
  discord
  (yazi.override {
	_7zz = _7zz-rar;
  })
  wireguard-tools
 ];

  networking.wg-quick.interfaces.proton = {
    configFile = "/etc/wireguard/proton.conf"; 
    autostart = true;                          
  };

  services.resolved.enable = true;
  networking.networkmanager.dns = "systemd-resolved";

  networking.networkmanager.unmanaged = [ "interface-name:proton" ];

#---

  #Time
  time.timeZone = "Europe/London";

  #Locales
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  #Enable the X11 windowing system.
  services.xserver.enable = true;

  #Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  #Configure keymap in X11
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  #Configure console keymap
  console.keyMap = "uk";

  #Enable CUPS to print documents.
  services.printing.enable = true;

  #Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };



 #Services
 #services.openssh.enable = true;

 #Firewall
	#Open Ports
	#networking.firewall.allowedTCPPorts = [ ... ];
	#networking.firewall.allowedUDPPorts = [ ... ];

	#Disable Firewall
	#networking.firewall.enable = false;

  system.stateVersion = "25.05";
}
