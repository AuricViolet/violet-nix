# ─────────────────────────────────────────────────────────────────────────
# 📦 System Packages
# ─────────────────────────────────────────────────────────────────────────
{ pkgs, config, inputs, lib, nvf, ... }:
{

environment.systemPackages = with pkgs; [
    mission-center
    grimblast
    gst_all_1.gstreamer
    mpvpaper
    vesktop
    pciutils
    hyprutils
    hyprgraphics
    hyprpolkitagent
    gamemode
    egl-wayland
    oreo-cursors-plus
    kdePackages.wacomtablet
    kdePackages.sddm-kcm
    kdePackages.dolphin
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
    fragments
    yabridge
    yabridgectl
    krita
    blender
    #(blender.override { cudaSupport = true; })


    #Coding Stuff
    dotnetCorePackages.sdk_9_0
    godot-mono
    vscode-fhs
    blender
    audacity
    distrobox
    wf-recorder
    libnotify
    slurp
    wl-clipboard
    cliphist

    #gaming stuff
    protontricks
    winetricks
    protonup-qt
    wineWowPackages.yabridge
    calibre
    sddm-astronaut
    (pkgs.catppuccin-sddm.override {
      flavor = "mocha";
      accent = "mauve";
      font  = "Noto Sans";
      fontSize = "9";
      background = "${./wallpaper.png}";
      loginBackground = true;
    })
  ];
  programs = {
    hyprland.enable = true;
    #yazi.enable = true;
    virt-manager.enable = true;
    gamescope.enable = true;
    gamemode.enable = true;
    steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
    gamescopeSession = {
        enable = true;
      };
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
    NIXOS_OZONE_WL = "1";
    LIBVA_DRIVER_NAME = "nvidia";
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
  virtualisation.libvirtd = {
  enable = true;
  };

  virtualisation.podman = {
      enable = true;
      dockerCompat = true;
    };

}
