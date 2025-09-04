{ config, pkgs, inputs, lib, chaotic, ... }:

{

security.rtkit.enable = true;
services = {
  openssh.enable = true;
  xserver.enable = true;
  libinput.enable = true;
    displayManager = {
      sddm.enable = true;
      sddm.theme = "catppuccin-mocha";
      sddm.wayland.enable = true;
      defaultSession = "plasma";
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
