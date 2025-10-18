{ pkgs, ... }:

{
  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  # Wayland-friendly environment bits


  environment.sessionVariables = {
    # Wayland + NVIDIA happy path
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
    __GL_GSYNC_ALLOWED = "0";
    __GL_VRR_ALLOWED = "0";

    # Only expose NV Vulkan ICDs (both 64 and 32-bit for Proton)
    VK_ICD_FILENAMES =
      "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.json:/run/opengl-driver-32/share/vulkan/icd.d/nvidia_icd.json";
  };





  programs.hyprlock.enable = true;
  services.hypridle.enable = true;

  environment.systemPackages = with pkgs; [
    # Hyprland ecosystem helpers
    pyprland
    hyprpicker
    hyprcursor
    hyprlock
    hypridle
    hyprpaper
    hyprsunset
    hyprpolkitagent

    waybar
    wofi

    # Shell / editor / tools you referenced
    starship
    helix

    # Nice Wayland-native apps often used with Hyprland
    qutebrowser
    zathura
    mpv
    imv
  ];
}

