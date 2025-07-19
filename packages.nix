# ─────────────────────────────────────────────────────────────────────────
# 📦 System Packages
# ─────────────────────────────────────────────────────────────────────────
{ pkgs, config, inputs, neve, lib, ... }:
{


environment.systemPackages = with pkgs; [
    vesktop
    kdePackages.wacomtablet
    libwacom
    haruna
    pinta
    onlyoffice-desktopeditors
    git
    gh
    github-desktop
    python312
    haruna
    zip
    rar
    kdePackages.sddm-kcm
    unzip
    pwvucontrol
    gearlever
    easyeffects
    fastfetch
    appimage-run
    p3x-onenote
    ananicy-cpp
    ananicy-rules-cachyos
    qbittorrent
    cudaPackages.cudatoolkit
    (blender.override { cudaSupport = true; })

    #Coding Stuff
    godot-mono
    vscode-fhs
    wasm-tools
    dotnetCorePackages.sdk_9_0_3xx
    blender
    audacity
    obsidian

    #gaming stuff
    ryujinx
    protontricks
    winetricks
    wineWowPackages.stable
    calibre
    inputs.Neve.packages.${pkgs.system}.default
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
          pkgs.libxcrypt
          pkgs.libxcrypt-legacy
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
    KDE_NO_PRELOADING = "0";
    MOZ_ENABLE_WAYLAND = "1";
    __GL_MaxFramesAllowed = "1";
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

  virtualisation = {
    docker = {
      enable = true;
      autoPrune.enable = true;
      enableOnBoot = true;
    };
  };

}
