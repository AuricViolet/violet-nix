{ pkgs, pkgs-stable, chaotic, config, inputs, lib, ... }:
{
environment.systemPackages = (with pkgs; [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    mission-center
    lmstudio
    ananicy-rules-cachyos_git
    openal
    grimblast
    mpvpaper
    vesktop
    mangohud
    kdePackages.spectacle
    clang
    clang-tools
    pciutils
    kdePackages.kcalc
    low-latency-layer
    hyprpolkitagent
    egl-wayland
    yabridge
    yabridgectl
    oreo-cursors-plus
    kdePackages.wacomtablet
    kdePackages.sddm-kcm
    rocmPackages.rocminfo
    rocmPackages.rocm-smi
    python3
    haruna
    android-tools
    git
    rar
    pwvucontrol
    easyeffects
    wineWow64Packages.stable
    p3x-onenote
    qbittorrent
    jackett
    krita
    fetch
    p7zip
    wineWow64Packages.stable
    dotnetCorePackages.sdk_9_0
    rustc
    rustup
    cargo
    libnotify
    slurp
    imagemagick
    wl-clipboard
    protontricks
    winetricks
    ripgrep
    protonup-rs
    alcom
    unityhub
    xivlauncher
    vscode-fhs
    fastfetch
    godot-mono
    blender
    (pkgs.catppuccin-sddm.override {
      flavor = "mocha";
      accent = "mauve";
      font  = "Noto Sans";
      fontSize = "9";
      background = "${./assets/wallpapers/snowyforest.jpg}";
      loginBackground = true;
    })
  ]) ++ (with pkgs-stable; [
    reaper
  ]);

  programs = {
    bash.shellAliases = {
      switch = "sudo nixos-rebuild switch";
    };
    gpu-screen-recorder.enable = true;
    yazi.enable = true;
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        #wlrobs
        obs-vaapi
        #obs-pipewire-audio-capture
        #obs-gstreamer
        #obs-vkcapture
     ];
    };
    hyprland.enable = true;
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
          pkgs.mesa
          pkgs.vulkan-loader
          pkgs.vulkan-tools
          pkgs.zstd
        ];
      };
    };
};

 environment.sessionVariables = {
    KWIN_LOW_LATENCY = "1";
    LOW_LATENCY_LAYER= "1";
    KDE_NO_PRELOADING = "0"; 
    MOZ_ENABLE_WAYLAND= "1";
    NIXOS_OZONE_WL = "1";
    STEAM_FORCE_WAYLAND = "1";
    XDG_MENU_PREFIX = "plasma-";
    AMD_VULKAN_ICD = "RADV";
  };

  fonts = {
    fontconfig.cache32Bit = true;
    fontconfig.enable = true;
    packages = with pkgs; [
      font-awesome_4
      dejavu_fonts
      liberation_ttf
      noto-fonts
      corefonts
      nerd-fonts.mononoki
      ];
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
  ];
}
