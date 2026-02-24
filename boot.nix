{ config, pkgs, inputs, lib, nix-gaming, ... }:

{ # ─────────────────────────────────────────────────────────────────────────
  # ❄️ Bootloader & Kernel Setup
  # ─────────────────────────────────────────────────────────────────────────
  boot = {
    extraModprobeConfig = ''
  options cfg80211 ieee80211_regdom="CA"
'';
   kernel.sysctl."vm.swappiness" = 10;
   kernelModules= ["amdgpu" "amd_iommu=on"];
   kernelPackages = pkgs.linuxPackages_latest;
   kernelParams = ["quiet" "splash" "systemd.show_status=false" "boot.shell_on_fail" "udev.log_priority=3" "rd.systemd.show_status=auto" "preempt=full"];
   initrd.systemd.enable = true;
    loader = {
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 5; #Keep the 5 last Generations
      efi.canTouchEfiVariables = true;
    };
};
}
