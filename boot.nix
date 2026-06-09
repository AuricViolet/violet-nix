{ config, pkgs, inputs, lib, ... }:

{ 
  boot = {
   kernel.sysctl."vm.swappiness" = 10;
   kernelModules= ["amdgpu"];
   kernelPackages = pkgs.linuxPackages_latest;
   kernelParams = ["boot.shell_on_fail" "udev.log_priority=3" "rd.systemd.show_status=auto" "preempt=full"];
   initrd.systemd.enable = true;
    loader = {
      systemd-boot.enable = false;
      limine.enable = true;
      #systemd-boot.consoleMode = "max";
      limine.maxGenerations = 3;
      efi.canTouchEfiVariables = true;
    };
};
}
