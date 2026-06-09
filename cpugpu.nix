{config,pkgs,lib, ... }:
{
  powerManagement.cpuFreqGovernor = "performance";
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      libva-vdpau-driver
      rocmPackages.clr.icd
      libvdpau-va-gl
      mesa
      libva
      libva-utils
    ];
  };
  hardware.amdgpu.opencl.enable = true;
  hardware.graphics.enable32Bit = true;
  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableAllFirmware = true;
  hardware.firmware = with pkgs; [ wireless-regdb ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.enableRedistributableFirmware = true;
  hardware.bluetooth.enable = true;
  services.ananicy.enable = true;
  services.ananicy.package = pkgs.ananicy-cpp;
  services.ananicy.rulesProvider = pkgs.ananicy-rules-cachyos;
}
