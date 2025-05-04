# ─────────────────────────────────────────────────────────────────────────
# 📦 System Packages
# ─────────────────────────────────────────────────────────────────────────
{ pkgs, config, inputs, neve, lib, ... }:
{
environment.systemPackages = with pkgs; [
    gparted
    cacert
    git
    zip
    rar
    unzip
    p7zip
    wget
    pwvucontrol
    toybox
    vesktop
    gearlever
    easyeffects
    fragments
    fastfetch
    appimage-run
    p3x-onenote
    moonlight-qt
    krita
    cabextract
    ananicy-cpp
    ananicy-rules-cachyos
    #faudio

    #Coding Stuff
    obsidian
    vscode-fhs
    unityhub
    dotnetCorePackages.dotnet_9.sdk
    godot_4_3

    #gaming stuff
    ryujinx
    bottles
    lutris
    heroic
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
    virt-manager.enable = true;

    appimage = {
      enable = true;
      binfmt = true;
      package = pkgs.appimage-run.override {
        extraPkgs = pkgs: [
          pkgs.icu
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
    XDG_CACHE_HOME = "/home/isolde/.cache";
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
  ];

}
