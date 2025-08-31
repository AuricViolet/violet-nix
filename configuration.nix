# ───────────────────────────────────────────────────────────────────────────
# ❄️ Cozy NixOS: Winter Wonderland Config ❄️
# ───────────────────────────────────────────────────────────────────────────

{ config, pkgs, inputs, spicetify-nix, lib, chaotic, nix-gaming, neve, ... }:

{
  # ─────────────────────────────────────────────────────────────────────────
  # 🧊 Glacier Imports
  # ─────────────────────────────────────────────────────────────────────────
  imports = [
    ./hardware-configuration.nix
    inputs.spicetify-nix.nixosModules.default
    ./packages.nix
    ./cpugpu.nix
    ./boot.nix
    ./services.nix
    ./spicetify.nix
    ./nixvim.nix
  ];

  # ─────────────────────────────────────────────────────────────────────────
  # 🧤 Swapfile Setup (16GB)
  # ─────────────────────────────────────────────────────────────────────────
  swapDevices = [{
    device = "/swapfile";
    size = 16 * 1024;
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
  security.pam.loginLimits = [
  {
    domain = "@audio";  # applies to all users in the audio group
    type = "-";
    item = "rtprio";
    value = "95";
  }
  {
    domain = "@audio";
    type = "-";
    item = "memlock";
    value = "unlimited";
  }
];



  # ─────────────────────────────────────────────────────────────────────────
  # ❄️ Flake magic & nix settings
  # ─────────────────────────────────────────────────────────────────────────
  nix.settings = {
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

  # ─────────────────────────────────────────────────────────────────────────
  # ❄️ Suspend/Sleep
  # ─────────────────────────────────────────────────────────────────────────
  systemd.targets = {
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    hybrid-sleep.enable = false;
  };
    systemd.user.services."app-org.kde.kalendarac@autostart".enable = false;
  #──────────────────────────────────────────────────────────────────────────
  # 🧊 User Setup: isolde
  # ─────────────────────────────────────────────────────────────────────────
  users.users.isolde = {
    isNormalUser = true;
    #hashedPasswordFile
    description = "isolde";
    extraGroups = [ "networkmanager" "wheel" "docker" "audio" "gamemode" "video" "kvm" "libvirtd"];
    packages = with pkgs; [
    kdePackages.kate
    kdePackages.filelight
    ];
  };

security.sudo = {
  enable = true;
  wheelNeedsPassword = false;
};

#─────────────────────────────────────────────────────────────────────────
  # Unfree packages allowed
  # ─────────────────────────────────────────────────────────────────────────
  nixpkgs.config.allowUnfree = true;

}
