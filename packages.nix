# ─────────────────────────────────────────────────────────────────────────
# 📦 System Packages
# ─────────────────────────────────────────────────────────────────────────
{ pkgs, config, inputs, lib, nvf, ... }:
{

environment.systemPackages = with pkgs; [
    btop
    libva-utils
    hyprutils
    hyprpolkitagent
    nvidia-vaapi-driver
    hyprland-qt-support
    egl-wayland
    oreo-cursors-plus
    grimblast
    fluffychat
    kdePackages.wacomtablet
    kdePackages.sddm-kcm
    reaper
    haruna
    git
    github-desktop
    rar
    pwvucontrol
    gearlever
    easyeffects
    fastfetch
    appimage-run
    p3x-onenote
    cudatoolkit
    fragments
    yabridge
    yabridgectl
    krita
    (blender.override { cudaSupport = true; })


    #Coding Stuff
    dotnetCorePackages.sdk_9_0
    godot-mono
    vscode-fhs
    blender
    audacity
    distrobox

    #gaming stuff
    protontricks

    winetricks
    protonup-qt
    wineWowPackages.yabridge
    calibre
    (pkgs.catppuccin-sddm.override {
      flavor = "mocha";
      font = "Noto Sans";
      fontSize = "9";
      background = "${./wallpaper.png}";
      loginBackground = true;
    })
  ];
  programs = {
    hyprland = {
      enable = true;
    };
    yazi.enable = true;
    virt-manager.enable = true;
    gamescope.enable = true;
    gamemode.enable = true;
    steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
    };
    xwayland.enable = true;
    firefox.enable = true;
    dconf.enable = true;
    partition-manager.enable = true;
    appimage = {
      enable = true;
      binfmt = true;
      package = pkgs.appimage-run.override {
        extraPkgs = pkgs: [
          pkgs.icu
          pkgs.libxcrypt
          pkgs.libxcrypt-legacy
        ];
      };
    };
};
# ─────────────────────────────────────────────────────────────────────────
# 🌬️ Environment Variables
# ─────────────────────────────────────────────────────────────────────────
 environment.sessionVariables = {
    KWIN_LOW_LATENCY = "1";
    KDE_NO_PRELOADING = "0";
    MOZ_ENABLE_WAYLAND= "1";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    #NIXOS_OZONE_WL = "1";
    LIBVA_DRIVER_NAME = "nvidia";


    #XDG_CACHE_HOME = "/home/isolde/.cache";
  };

# ─────────────────────────────────────────────────────────────────────────
# 🧊 Fonts & exclusions
# ─────────────────────────────────────────────────────────────────────────
  fonts = {
    fontconfig.cache32Bit = true;
    fontconfig.enable = true;
    packages = with pkgs; [
    font-awesome
    dejavu_fonts
    liberation_ttf
    noto-fonts
    corefonts
    nerd-fonts.mononoki
    ];
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
    xwaylandvideobridge
  ];
  nixpkgs.config.android_sdk.accept_license = true;
  virtualisation.libvirtd = {
  enable = true;
  };
  virtualisation.podman = {
      enable = true;
      dockerCompat = true;
      #autoPrune.enable = true;
      #enableOnBoot = true;
    };

}
