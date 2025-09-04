# ─────────────────────────────────────────────────────────────────────────
# 📦 System Packages
# ─────────────────────────────────────────────────────────────────────────
{ pkgs, config, inputs, lib, nvf, ... }:
{

environment.systemPackages = with pkgs; [
    vesktop
    kdePackages.wacomtablet
    kdePackages.sddm-kcm
    reaper
    haruna
    pinta
    git
    github-desktop
    haruna
    rar
    pwvucontrol
    gearlever
    easyeffects
    fastfetch
    appimage-run
    p3x-onenote
    cudatoolkit
    fragments
    lutris
    kdePackages.kdialog
    (blender.override { cudaSupport = true; })


    #Coding Stuff
    godot-mono
    vscode-fhs
    dotnetCorePackages.sdk_8_0-bin
    blender
    krita
    audacity
    yabridge
    yabridgectl
    protonup-qt

    #gaming stuff
    protontricks
    winetricks
    distrobox
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
    neovim.enable = true;
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
# ─────────────────────────────────────────────────────────────────────────};
 environment.sessionVariables = {
    KWIN_LOW_LATENCY = "1";
    KDE_NO_PRELOADING = "0";
    MOZ_ENABLE_WAYLAND= "1";
    NIXOS_OZONE_WL = "1";
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
    ];
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
    xwaylandvideobridge
  ];
  virtualisation.podman = {
      enable = true;
      dockerCompat = true;
      #autoPrune.enable = true;
      #enableOnBoot = true;
    };

}
