{ config, pkgs, ... }:
{
  # Enable GNOME (the module adds the proper session files for your channel)
  services.xserver.desktopManager.gnome.enable = true;

  # Usual GNOME bits
  services.gnome.gnome-keyring.enable = true;
  programs.dconf.enable = true;
}

