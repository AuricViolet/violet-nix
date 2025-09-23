# ───────────────────────────────────────────────────────────────────────────
# ❄️ Cozy NixOS: Winter Wonderland Config ❄️
# ───────────────────────────────────────────────────────────────────────────

{ config, pkgs, inputs, spicetify-nix, lib, chaotic, ... }:

{
  # ─────────────────────────────────────────────────────────────────────────
  # 🧊 Glacier Imports
  # ─────────────────────────────────────────────────────────────────────────
  imports = [
    ./hardware-configuration.nix #hardware specific config including filesystem mounts, should rebuild this each new install with nixos-generate-config
    inputs.spicetify-nix.nixosModules.default #not sure if this needs to be here or not.
    ./packages.nix #packages
    ./cpugpu.nix #cpu/gpu specific configs
    ./boot.nix #boot configuration
    ./services.nix #services and system options
    ./spicetify.nix #spicetify client with adblock
    ./nvf.nix #nvf for neovim
    ./stylix.nix
  ];

  # ─────────────────────────────────────────────────────────────────────────
  # 🧤 Swapfile Setup (16GB)
  # ─────────────────────────────────────────────────────────────────────────
  swapDevices = [{
    device = "/swapfile";
    size = 16 * 1024; #creates a 16gb swapfile, to help the OS not crash if RAM fills up.
   
  }];

  # ─────────────────────────────────────────────────────────────────────────
  # 🐧 Core System Settings
  # ─────────────────────────────────────────────────────────────────────────
  system.stateVersion = "25.05"; 
  time.timeZone = "America/Halifax";
  i18n.defaultLocale = "en_CA.UTF-8";
  networking.hostName = "boreas";
  networking.networkmanager.enable = true;
  system.autoUpgrade = {
    enable = false;
    allowReboot = false;
     };


  # ─────────────────────────────────────────────────────────────────────────
  # ❄️ Flake magic & nix settings
  # ─────────────────────────────────────────────────────────────────────────
  nix.settings = {
    download-buffer-size = 536870912;
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
    substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
      ]; #2 caches to fetch from, this speeds up build time.
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
  };
  nix.optimise.automatic =true; #helps the store stay optimized and saves on storage space
    nix.gc = { #garbage collection
      automatic = true;
      dates = "daily";
      options = "-d";
    };

  # ─────────────────────────────────────────────────────────────────────────
  # ❄️ Suspend/Sleep
  # ─────────────────────────────────────────────────────────────────────────
  systemd.targets = { #stops the system from sleeping and suspending 
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    hybrid-sleep.enable = false;
  };
    #systemd.user.services."app-org.kde.kalendarac@autostart".enable = false;
  #──────────────────────────────────────────────────────────────────────────
  # 🧊 User Setup: isolde
  # ─────────────────────────────────────────────────────────────────────────
  users.users.isolde = {
    isNormalUser = true;
    #hashedPasswordFile
    description = "isolde";
    extraGroups = [ "networkmanager" "wheel" "docker" "audio" "gamemode" "video"];
    packages = with pkgs; [
    kdePackages.kate
    kdePackages.filelight
    ];
  };
   security.sudo.wheelNeedsPassword = false;



#─────────────────────────────────────────────────────────────────────────
  # Unfree packages allowed
  # ─────────────────────────────────────────────────────────────────────────
  nixpkgs.config.allowUnfree = true;

}
