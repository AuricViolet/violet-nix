{ config, pkgs, inputs, lib, chaotic, nix-gaming, ... }:

{ # ─────────────────────────────────────────────────────────────────────────
  # ❄️ Bootloader & Kernel Setup
  # ─────────────────────────────────────────────────────────────────────────
  boot = {
   kernel.sysctl."vm.swappiness" = 10;
   kernelModules= ["nvidia" "nvidia-uvm"];
   kernelPackages = pkgs.linuxPackages_cachyos;
    kernelParams = [ "quiet" "splash" "systemd.show_status=false" "boot.shell_on_fail" "udev.log_priority=3" "rd.systemd.show_status=auto" "nvidia_drm.modeset=1" "preempt=full"];
    initrd.kernelModules = [
    "nvidia"
];

    loader = {
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 5; #Keep the 5 last Generations
      efi.canTouchEfiVariables = true;

    };

  };
}
