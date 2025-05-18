# ─────────────────────────────────────────────────────────────────────────
# 📦 System Packages
# ─────────────────────────────────────────────────────────────────────────
{ pkgs, config, inputs, neve, lib, ... }:
{


environment.systemPackages = with pkgs; [
    kdePackages.qtmultimedia
    moonlight-qt
    steam-run
    thefuck
    haruna
    kdePackages.filelight
    blender
    cavalier
    pinta
    python310Packages.certifi
    cacert
    onlyoffice-desktopeditors
    git
    icu
    python312
    haruna
    zip
    rar
    unzip
    krita
    pwvucontrol
    vesktop
    gearlever
    easyeffects
    fragments
    fastfetch
    appimage-run
    p3x-onenote
    ananicy-cpp
    ananicy-rules-cachyos

    #Coding Stuff
    obsidian
    python310
    vscode-fhs
    unityhub
    dotnetCorePackages.dotnet_9.sdk

    #gaming stuff
    ryujinx
    bottles
    lutris
    heroic
    protontricks
    winetricks
    wineWowPackages.stable
    calibre
    (pkgs.catppuccin-sddm.override {
      flavor = "mocha";
      font = "Noto Sans";
      fontSize = "9";
      background = "${./wallpaper.png}";
      loginBackground = true;
    })
  ];
   programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
    gamescopeSession.enable = true;
  };

  programs = {
    gamemode.enable = true;
    dconf.enable = true;
    partition-manager.enable = true;
    appimage = {
      enable = true;
      binfmt = true;
      package = pkgs.appimage-run.override {
        extraPkgs = pkgs: [
          pkgs.icu
          pkgs.libxcrypt-legacy
          pkgs.glibc
          pkgs.libGL
          pkgs.python310Packages.certifi
          pkgs.cacert
          pkgs.zlib
          pkgs.mesa
          pkgs.libffi
          pkgs.expat
          pkgs.fontconfig
          pkgs.freetype
          pkgs.vulkan-loader
          pkgs.xdg-utils
          pkgs.wayland
        ];
      };
    };
    firefox.enable = true;
};
# ─────────────────────────────────────────────────────────────────────────
# 🌬️ Environment Variables
# ─────────────────────────────────────────────────────────────────────────};
 environment.sessionVariables = {
    KWIN_LOW_LATENCY = "1";
    KWIN_TRIPLE_BUFFER = "1";
    KWIN_COMPOSE = "O2";
    KDE_NO_PRELOADING = "0";
    BALOO_DISABLE = "1";
    MOZ_ENABLE_WAYLAND = "1";
    #XDG_CACHE_HOME = "/home/isolde/.cache";
    #NIXOS_OZONE_WL = "1";
  };

# ─────────────────────────────────────────────────────────────────────────
# 🧊 Fonts & exclusions
# ─────────────────────────────────────────────────────────────────────────
  fonts = {
    fontconfig.cache32Bit = true;
    packages = with pkgs; [ font-awesome ];
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
    xwaylandvideobridge
    korganizer
    khelpcenter
    akonadi
    baloo
  ];

}
