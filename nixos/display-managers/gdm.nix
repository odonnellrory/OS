# nixos/display-managers/gdm.nix
{ config, pkgs, lib, ... }:

{
  # Make sure other DMs are off if this module is imported
  services.greetd.enable = lib.mkForce false;
  services.displayManager.sddm.enable = lib.mkForce false;

  # GDM lives under xserver.* on your release
  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = true;   # keep GDM on Wayland when available
  };

  # Keep the Wayland/NVIDIA env you used with greetd
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}

