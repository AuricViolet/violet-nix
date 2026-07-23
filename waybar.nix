{ config, lib,  pkgs, stylix, home-manager, ... }:
{
  programs = {
  waybar.enable = true;
    waybar.settings = {
      mainBar = {
        mode = "dock";
        spacing = 5;
        layer = "top";
        position = "top";
        height = 25;
        modules-left = [ "image" "network" ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right = [ "pulseaudio" "cava" "clock" ];
        persistent-workspaces = {
            "DP-3" = 1;
            "HDMI-A-1" = 2;
          };
          
        "clock"= {
          format = "{:%I:%M %p}";
          tooltip-format = "{:%A, %B %d, %Y}";
        };
        "network"= {
          format = "{ifname}";
          format-wifi = " ";
          format-disconnected =  "";
          tooltip-format-wifi = "{essid} ({signalStrength}%) ";
          tooltip-format-disconnected = "Disconnected";
          max-length = 25;
          on-click = "exec kitty nmtui";
        };
        "image"= {
          path = "/etc/nixos/assets/avatar.png";
          size = 25;
          interval = 3600;
          on-click = "exec fuzzel -w 30 -y 12 -f ''Roboto''-15 --line-height=20";
        };
        "cava"= {
          framerate = 60;
          on-click = "exec easyeffects";
          bars = 14;
          hide_on_silence = false;
          method = "pipewire";
          stereo = true;
          bar_delimiter = 0;
          monstercat = true;
          format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
          };
        
        };
        };
        waybar.style = ''
          window#waybar {
            background-color: rgba(17, 17, 27, 0.75);
          }

          *{
            font-family: mononoki;
          }
          #workspaces button {
            font-size: 7px;
            padding: 0 2px;   
            border-radius: 6px;
            min-height: 0;
            margin: 0;
          }
         #workspaces button label {
              padding: 0;
              margin: 0;
              min-height: 0;
              color: rgba(203, 166, 247, 0.75);
          }
        #image {
          border-radius: 6px;
          margin: 0 3px;
        }
        #pulseaudio,
        #clock,
        #cava,
        #network { 
          color: rgba(203, 166, 247, 0.75);
        }
        #workspaces {
          border-radius: 1px;
          color: rgba(203, 166, 247, 0.75);
          padding: 0 1px;
          min-height: 0;
        }
      '';
  };
}
