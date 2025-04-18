# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, spicetify-nix,lib, chaotic,nix-gaming,neve, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.spicetify-nix.nixosModules.default #imports spicetify for spotify themeing

    ];

  programs.nix-ld = {
    enable = true;
    libraries = pkgs.steam-run.args.multiPkgs pkgs;
  };

  # Creates a 16GB swap file, pages to disk if RAM overflows
  swapDevices = [{ device = "/swapfile"; size = 16 * 1024; }];
    #zramSwap = {
    #enable = true;
    #algorithm = "zstd";
    #priority = 100;
  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };
  hardware.cpu.amd.updateMicrocode = true;
#disable annoying KDE services on boot

systemd.user.services."app-org.kde.kalendarac@autostart".enable = false;
systemd.user.services."app-org.kde.kunifiedpush\x2ddistributor@autostart".enable = false;
  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    nvidiaPersistenced = true;
  };

  #Keep only the previous 5 generations, discard all others daily, optimize store for storage.

  nix.settings.auto-optimise-store = true;
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "-d --delete-older-than +5";

  #upgrade to latest kernel version
  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  boot.kernelParams = [ "amd_pstate=guided" "quiet" "splash" "systemd.show_status=false"];
  boot.initrd.kernelModules = [ "nvidia" ];
  #powerManagement.enable = true;
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernel.sysctl = {
  "vm.nr_hugepages" = 128;
  "vm.swappiness" = 60;  # Try increasing swappiness to encourage swap usage before freezing
};

  boot.plymouth = {
  enable = true;
  theme = "spinfinity";};# or "spinfinity", "fade-in", etc.
# Adjust based on your workload

  # Disable the systemd auto-suspend feature that cannot be disabled in GUI!
  # If no user is logged in, the machine will power down after 20 minutes.
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  #Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes"];

  networking.hostName = "boreas"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Halifax";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.theme = "catppuccin-mocha";
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.defaultSession = "plasma";
  #services.hypridle.enable = true;
  services.scx.enable = true; # by default uses scx_rustland scheduler
  services.printing.enable = false;
  services.blueman.enable = false; # Disable Bluetooth if unused


  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    audio.enable = true;
    pulse.enable = true;
    jack.enable = true;
    };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.isolde = {
    isNormalUser = true;
    description = "isolde";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };


  # Install Apps from nixos repo.
  programs.firefox.enable = true;
  programs.steam = {
  enable = true;
  extraCompatPackages = [ pkgs.proton-ge-bin ];
  };
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;
  programs.dconf.enable = true;
  #enable app image interpreter
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
  programs.appimage.package = pkgs.appimage-run.override { extraPkgs = pkgs: [
    pkgs.icu
    pkgs.libxcrypt-legacy
    pkgs.python312
    pkgs.python312Packages.torch
    pkgs.cudaPackages.cudnn
    pkgs.cudaPackages.cudatoolkit
    pkgs.libGL
    pkgs.python312Packages.torchvision
  ]; };
  programs.hyprland.enable = true;
  programs.hyprlock.enable = true;
  programs.partition-manager.enable = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  #modded spotify with adblock and catppuccin mocha theme

  programs.spicetify =
  let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in
  {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
      shuffle # shuffle+ (special characters are sanitized out of extension names)
  ];
  enabledCustomApps = with spicePkgs.apps; [
    newReleases
    ncsVisualizer
    marketplace

  ];
  enabledSnippets = with spicePkgs.snippets; [
    pointer
  ];

  theme = spicePkgs.themes.catppuccin;
  colorScheme = "mocha";
};

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages = with pkgs; [
    #inputs.nix-gaming.packages.${pkgs.system}.<package>
    pkgs.lutris
    pkgs.kitty
    kdePackages.plasma-workspace
    kdePackages.kde-gtk-config
    kdePackages.kwin
    kdePackages.systemsettings
    git
    zip
    unzip
    pkgs.cudaPackages.cudnn
    pkgs.cudaPackages.cudatoolkit
    pkgs.python313Packages.torchvision
    pkgs.libGL
    pkgs.vesktop
    pkgs.gearlever
    pkgs.easyeffects
    pkgs.fragments
    pkgs.fastfetch
    pkgs.appimage-run
    pkgs.hyprland
    pkgs.waybar
    pkgs.winetricks
    pkgs.wineWowPackages.waylandFull
    pkgs.protontricks
    pkgs.rofi
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.faudio
    pkgs.kdePackages.filelight
    pkgs.calibre
    (pkgs.catppuccin-sddm.override {
    flavor = "mocha";
    font  = "Noto Sans";
    fontSize = "9";
    background = "${./wallpaper.png}";
    loginBackground = true;
  }
)
  ];

  environment.sessionVariables = {
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    KWIN_TRIPLE_BUFFER = "1";  # Smoother rendering
    KWIN_COMPOSE = "O2";       # Faster startup
    KDE_NO_PRELOADING = "0";
    BALOO_DISABLE = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QUICK_BACKEND = "opengl";
    #KWIN_TRIPLE_BUFFER = "1";
    KWIN_BACKEND = "vulkan";
    KWIN_LOW_LATENCY = "1";
  #If your cursor becomes invisible
  #WLR_NO_HARDWARE_CURSORS = "1";
  #Hint electron apps to use wayland
  NIXOS_OZONE_WL = "1";
};
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  fonts.fontconfig.cache32Bit = true;
  fonts.packages = with pkgs; [
    font-awesome
   ];

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
  elisa
  xwaylandvideobridge
  korganizer
  khelpcenter
  akonadi

];
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
