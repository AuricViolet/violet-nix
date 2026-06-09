{ pkgs, nixpkgs-unstable, config, inputs, lib, ... }:
{
environment.systemPackages = (with pkgs; [
    mission-center
    grimblast
    mpvpaper
    vesktop
    mangohud
    kdePackages.spectacle
    clang
    clang-tools
    pciutils
    hyprutils
    hyprgraphics
    kdePackages.kcalc
    hyprpolkitagent
    egl-wayland
    yabridge
    yabridgectl
    oreo-cursors-plus
    heroic
    gearlever
    icu
    kdePackages.wacomtablet
    kdePackages.sddm-kcm
    reaper
    haruna
    fragments
    android-tools
    git
    rar
    vscodium-fhs
    pwvucontrol
    easyeffects
    fastfetch
    wineWow64Packages.stable
    wineWowPackages.stable
    p3x-onenote
    qbittorrent
    jackett
    krita
    p7zip
    video-downloader
    wineWow64Packages.stable
    dotnetCorePackages.sdk_9_0
    rustc
    rustup
    cargo
    wf-recorder
    yt-dlp
    libnotify
    slurp
    wl-clipboard
    cliphist
    lmstudio
    protontricks
    winetricks
    ripgrep
    protonup-qt
    rocmPackages.rocm-runtime
    rocmPackages.clr
    rocmPackages.rocblas
    (pkgs.catppuccin-sddm.override {
      flavor = "mocha";
      accent = "mauve";
      font  = "Noto Sans";
      fontSize = "9";
      background = "${./wallpaper.png}";
      loginBackground = true;
    })
  ]) ++ (with nixpkgs-unstable; [
    alcom
    unityhub
    xivlauncher
    vscode-fhs
    godot-mono
    blender
  ]);

  programs = {
    nix-ld.enable = true;
    virt-manager.enable = true;
    yazi.enable = true;
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-vaapi
        obs-pipewire-audio-capture
        obs-gstreamer
        obs-vkcapture
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
    KDE_NO_PRELOADING = "0";
    MOZ_ENABLE_WAYLAND= "1";
    NIXOS_OZONE_WL = "1";
    STEAM_FORCE_WAYLAND = "0";
    XDG_MENU_PREFIX = "plasma-";
    AMD_VULKAN_ICD = "RADV";
  };

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
  ];
  virtualisation.docker.enable = true;
  virtualisation.libvirtd = {
  enable = true;
  };

  #virtualisation.podman = {
      #enable = true;
      #dockerCompat = true;
    #};

}
