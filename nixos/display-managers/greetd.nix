# nixos/display-managers/greetd.nix

{ config, pkgs, lib, ... }:

{
  services.displayManager.sddm.enable = lib.mkForce false;

  services.greetd = {
    enable = true;
    vt = 1;

    settings = {
      default_session = {
        user = "greeter";
        command = ''
          ${pkgs.greetd.tuigreet}/bin/tuigreet \
            --time \
            --remember \
            --asterisks \
            --user-menu \
            --greeting "Welcome" \
            --sessions /run/current-system/sw/share/wayland-sessions:/run/current-system/sw/share/xsessions:${pkgs.gnome-session}/share/wayland-sessions:${pkgs.gnome-session}/share/xsessions
        '';
      };
    };
  };

  environment.systemPackages = with pkgs; [
    greetd.tuigreet
    uwsm
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}

