# ─────────────────────────────────────────────────────────────────────────
# ⛷️ CPU & GPU Support
# ─────────────────────────────────────────────────────────────────────────
{config,pkgs,lib, ... }:
{
  powerManagement.cpuFreqGovernor = "performance";
  hardware.graphics = {
  enable = true;
};
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

system.stateVersion = "25.11";
}
