# ─────────────────────────────────────────────────────────────────────────
# ⚙️ Services
# ─────────────────────────────────────────────────────────────────────────
{ config, pkgs, inputs, lib, chaotic, ... }:
{
security.rtkit.enable = true;
services.gnome.gnome-keyring.enable = true;
xdg.portal.wlr.enable = true;
xdg.portal.enable = true;
services = {
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
  xserver.enable = true;
  libinput.enable = true;
    displayManager = {
      sddm.enable = true;
      #sddm.theme = "sddm-astronaut";
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
wireplumber.configPackages = [
  (pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/usb-audio.conf" ''
    monitor.alsa.rules = [
      {
        matches = [
          {
            device.name = "~alsa_card.usb-Burr-Brown_from_TI_USB_Audio_CODEC.*"
          }
        ]
        actions = {
          update-props = {
            api.alsa.use-acp = true
          }
        }
      }
      {
        matches = [
          {
            node.name = "~alsa_output.usb-Burr-Brown_from_TI_USB_Audio_CODEC.*"
          }
          {
            node.name = "~alsa_input.usb-Burr-Brown_from_TI_USB_Audio_CODEC.*"
          }
        ]
        actions = {
          update-props = {
            session.suspend-timeout-seconds = 0
          }
        }
      }
    ]
  '')
];
  };
};
}
