{
  config,
  pkgs,
  lib,
  ...
}:

{

  # ----------- # Imports # ----------- #

  imports = [
    ./hardware-configuration.nix
    ./desktop-environments/gnome.nix
    ./desktop-environments/hyprland.nix
    #./display-managers/greetd.nix
    ./display-managers/gdm.nix
  ];

  # ----------- # Firmware # ----------- #

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # ----------- # Networking # ----------- #

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # ----------- # Users # ----------- #

  users.users.rory = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "rory";
    
    extraGroups = [ 
      
      "networkmanager" 
      
      "wheel" 
      
      "docker"

      "input"

      "video"
    
    ];
    
    packages = with pkgs; [ 
    
    kdePackages.kate 
    
    ];
  
  };

  # ----------- # Programs # ----------- #

  programs.steam.enable = true;

  programs.ssh.askPassword =
    lib.mkForce "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";

  programs.git.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh.enable = true;
    ohMyZsh.plugins = [ "git" ];
  };

  # ----------- # Packages # ----------- #

  nixpkgs.config.allowUnfree = true;
#  nixpkgs.config.cudaSupport = true;

  environment.systemPackages = with pkgs; [
    vim
    protonvpn-cli
    neovim
    firefox
    wget
    btop
    lutris
    wineWowPackages.stable
    winetricks
    alacritty
    kitty
    ncdu
    discord
    wireguard-tools
    ollama
    nodejs_20
    gcc
    samba
    (yazi.override { _7zz = _7zz-rar; })

    networkmanagerapplet   
    blueman                
    pavucontrol

    kdePackages.breeze          
    numix-icon-theme-circle      

    playerctl brightnessctl grim slurp wl-clipboard wlogout

  ];

  # ----------- # Services # ----------- #

  services.flatpak.enable = true;

  virtualisation.docker.enable = true;


  # ----------- # Fonts # ----------- #
fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji

      font-awesome         # FA 6 in 25.05
      material-icons       # provides the "Material Icons" TTF

      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      nerd-fonts.symbols-only  # the “Symbols Nerd Font” fallback
    ];
  };
  # ----------- # LLM # ----------- #

#  services.ollama = {
#    enable = true;
#    acceleration = "cuda";
#  };

  # ----------- # DNS # ----------- #

  services.resolved.enable = true;
  networking.networkmanager.dns = "systemd-resolved";

  # ----------- # Locales # ----------- #

  time.timeZone = "Europe/London";
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

  # ----------- # X11 / Wayland # ----------- #

  services.xserver.enable = true;

  # ----------- # Keyboard # ----------- #

  services.xserver.xkb.layout = "gb";
  services.xserver.xkb.variant = "extd";
  console.keyMap = "uk";

  # ----------- # Printing # ----------- #

  services.printing.enable = true;

  # ----------- # Audio # ----------- #

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # ----------- # Nvidia # ----------- #

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = false;
  };

  xdg.portal.enable = true;


# ----------- # System # ----------- #

  system.stateVersion = "25.05";
}

