{ config, pkgs, inputs, spicetify-nix, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix #hardware specific config including filesystem mounts, should rebuild this each new install with nixos-generate-config
    inputs.spicetify-nix.nixosModules.default #not sure if this needs to be here or not.
    ./packages.nix #packages
    ./cpugpu.nix #cpu/gpu specific configs
    ./boot.nix #boot configuration
    ./services.nix #services and system options
    ./spicetify.nix #spicetify client with adblock
    ./stylix.nix
    ./nixvim.nix

  ];

  zramSwap.enable = true;
  hardware.i2c.enable = true;
  system.stateVersion = "26.05";
  time.timeZone = "America/Halifax";
  i18n.defaultLocale = "en_CA.UTF-8";
  networking.hostName = "boreas";
  networking.networkmanager.enable = true;
  system.autoUpgrade = {
    enable = false;
    allowReboot = false;
  };

  nix.settings = {
    download-buffer-size = 536870912;
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
    substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
  };
  nix.optimise.automatic =true;
    nix.gc = { 
      automatic = true;
      dates = "daily";
      options = "-d";
    };
  systemd.targets = { 
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    hybrid-sleep.enable = false;
  };
  users.users.isolde = {
    isNormalUser = true;
    description = "isolde";
    extraGroups = [ "networkmanager" "input" "wheel" "docker" "libvirtd" "audio" "gamemode" "video" "render"];
    packages = with pkgs; [
    kdePackages.kate
    kdePackages.filelight
    ];
    };

  security.pam.loginLimits = [
  {
    domain = "@audio";
    type = "-";
    item = "memlock";
    value = "unlimited";
  }
];
  security.sudo.wheelNeedsPassword = false;
  nixpkgs.config.allowUnfree = true;

}
