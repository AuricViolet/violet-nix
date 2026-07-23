{ config, pkgs, inputs, lib, chaotic, ... }:
{
  
security.rtkit.enable = true;
security.pam.services.sddm.enableGnomeKeyring = false;
security.pam.services.kwallet.enableKwallet = false;
services.gnome.gnome-keyring.enable = false;
xdg.portal.wlr.enable = false;
xdg.portal.enable = true;
xdg.portal.config = {
  common = {
    default = [ "hyprland" ];
  };
};
xdg.menus.enable = true;
xdg.mime.enable = true;
services = {
  scx.enable = true;
  xserver.xrandrHeads = [
    {
    output = "DP-3";
    primary = true;
    }
    {
    output = "HDMI-A-1";
    }
  ];
  dbus.enable = true;
  openssh.enable = true;
  wivrn.enable = true;
  wivrn.openFirewall = true;
  xserver.enable = true;
  libinput.enable = true;
  displayManager = {
    sddm.enable = true; 
    sddm.theme = "catppuccin-mocha-mauve";
    sddm.wayland.enable = true;
    defaultSession = "hyprland";

  };
  desktopManager.plasma6.enable = true;
  printing.enable = false;
  blueman.enable = false;
  pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    pulse.enable = true;
    extraConfig.pipewire."92-low-latency" = {
      "context.properties" = {
      "default.clock.rate" = 48000;
      "default.clock.quantum" = 32;
      "default.clock.min-quantum" = 32;
      "default.clock.max-quantum" = 128;
      };
    };
  };
};
}
