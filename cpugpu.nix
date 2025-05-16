# ─────────────────────────────────────────────────────────────────────────
# ⛷️ CPU & GPU Support
# ─────────────────────────────────────────────────────────────────────────
{config,pkgs, ... }:
{
  powerManagement.cpuFreqGovernor = "performance";
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableAllFirmware = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    #nvidiaPersistenced = true;
    #forceFullCompositionPipeline = true;
  };

services.ananicy.enable = true;
services.ananicy.package = pkgs.ananicy-cpp;
services.ananicy.rulesProvider = pkgs.ananicy-rules-cachyos;

system.stateVersion = "24.11";
}
