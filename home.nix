{ config, lib,  pkgs, stylix, home-manager, ... }:
{
  home.stateVersion = "25.05"; # Your Home Manager state version
  home.username = "isolde";    # your user

  home.packages = with pkgs; [
    hyprpaper
    waybar
    cava
    nautilus
    wofi
  ];

  home.sessionVariables = {
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
  };
  xdg.enable = true;
  services.network-manager-applet.enable = true;
  services.mako.enable = true;
  services.mako.settings = {
    "actionable=true" = {
      anchor = "top-right";
    };
    actions = true;
    anchor = "top-right";
    icons = true;
    layer = "top";
    markup = true;
    default-timeout = 5000;
    border-color = lib.mkForce "#cba6f7";
    background-color = lib.mkForce "#1e1e2e";
  };
  services.hypridle = {
    enable = true;
    settings = {
      general = {
      after_sleep_cmd = "hyprctl dispatch dpms on";
      ignore_dbus_inhibit = false;
      lock_cmd = "hyprlock";
    };
    listener = [
      {
      timeout = 900;
      on-timeout = "hyprlock";
      }
    {
      timeout = 1800;
      on-timeout = "hyprctl dispatch dpms off";
      on-resume = "hyprctl dispatch dpms on";
    }
  ];
    };
  };
  services.hyprpaper = {
    enable = false;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;
      preload = [ "/home/isolde/Pictures/walls/druid.jpg" ];
      wallpaper = [ ", /home/isolde/Pictures/walls/druid.jpg" ];
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = null;
    portalPackage = null;

    systemd = {
      enable = true;
      variables = [ "--all" ];
    };

    plugins = [
      pkgs.hyprland-protocols
    ];

    settings = {
      "$mod" = "SUPER";

      general = {
        gaps_out = 10;
        allow_tearing = true;
      };
      input = {
        follow_mouse = 2;
      };
      
      monitor = [
        "DP-3,2560x1440@180,0x0,1"
        "HDMI-A-1,1920x1080@60,2560x0,1,transform,3"
      ];

      misc = {
        key_press_enables_dpms = true;
        mouse_move_enables_dpms = true;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        render_unfocused_fps = 180;
      };
      render = {
        direct_scanout = 2;
      };

       workspace = [
      "1,monitor:DP-3,default:true"
      "2,monitor:DP-3"
      "3,monitor:DP-3"
      "4,monitor:DP-3"
      "5,monitor:DP-3"

      "6,monitor:HDMI-A-1,default:true"
      "7,monitor:HDMI-A-1"
      "8,monitor:HDMI-A-1"
      "9,monitor:HDMI-A-1"
      "10,monitor:HDMI-A-1"
    ];

      exec-once = [
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "mako"
        "easyeffects --gapplication-service"
        "waybar"
        "vesktop"
        "wl-paste --watch cliphist store"
        ''mpvpaper ALL -o "no-audio --loop-file=inf --panscan=1 --video-unscaled=no" /etc/nixos/window.mp4''
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bind =
        [
          "ALT, Tab, cyclenext"
          "ALT, Tab, bringactivetotop"
          "$mod, A, movewindow, l"
          "$mod, D, movewindow, r"
          "$mod, W, movewindow, u"
          "$mod, S, movewindow, d"

          "$mod, F, fullscreen"
          "$mod, T, exec, kitty"
          "$mod, R, exec, fuzzel -w 30 -y 12 -f ''Roboto''-15 --line-height=20 "
          "$mod, B, togglefloating,"
          "$mod, E, exec, nautilus"
          "$mod, Q, killactive,"
          "$mod, L, exec, hyprlock"
          "$mod, H, exec, cliphist list | wofi| cliphist decode | wl-copy"
          "$mod SHIFT, A, resizeactive, -30 0"
          "$mod SHIFT, D, resizeactive, 30 0"
          "$mod SHIFT, W, resizeactive, 0 -30"
          "$mod SHIFT, S, resizeactive, 0 30"

          ", Print, exec, grimblast copy area -f"
          "$mod, Print, exec, notify-send '🎥 Recording started' && wf-recorder -a -f ~/Videos/WFrecorder/recording-$(date +'%Y-%m-%d_%H-%M-%S').mp4 -r 60 -g \"$(slurp)\" -c h264_vaapi -d /dev/dri/renderD128"
          "$mod SHIFT, Print, exec, notify-send '✅ Recording stopped' && pkill -INT wf-recorder"
        ]
        ++ (
          builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          ) 9)
        );
    };
  };

programs = {
  fuzzel = {
    enable = true;
    settings = {
      main = {
        font = lib.mkForce "mononoki Nerd Font:size=15";
        icon-theme = "kora";
        icons-enabled = true;
      }; 
    };
  };


  hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = false;
        ignore_empty_input = true;
    };
    background = {
      path = "/etc/nixos/wallpaper.png";
      blur_passes = 1;
      blur_size = 8;
    };
    label = {
      monitor = "DP-3";
      text = "❄ $TIME ❄";
      font_size = 90;
      font_family = "monospace";
      position = "0, 200";
      halign = "center";
      valign = "center";
      shadow_passes = 2;
      outline_thickness = 5;
    };

    input-field = {
      size = "400, 70";
      monitor = "DP-3";
      shadow_passes = 2;
      outline_thickness = 5;
      rounding = 1;
    };
  };
};
    kitty = {
      enable = true;
      settings = {
        confirm_os_window_close = "0";
      };
    };
    waybar.enable = true;
    waybar.settings = {
      mainBar = {
        spacing = 5;
        layer = "top";
        position = "top";
        height = 25;
        modules-left = [ "image" "network" ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right = [  "pulseaudio" "cava" "clock" ];
        persistent-workspaces = {
            "DP-3" = 1;
            "HDMI-A-1" = 2;
          };
          
        "clock"= {
          format = "{:%I:%M %p}";
          tooltip-format = "{:%A, %B %d, %Y}";
        };
        "network"= {
          interface = "wlp10s0";
          format = "{ifname}";
          format-wifi = " ";
          format-disconnected =  "";
          tooltip-format-wifi = "{essid} ({signalStrength}%) ";
          tooltip-format-disconnected = "Disconnected";
          max-length = 25;
          on-click = "exec kitty nmtui";
        };
        "image"= {
          path = "/etc/nixos/avatar.png";
          size = 25;
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
    # Shell & startup
    bash.enable = true;
    bash.bashrcExtra = "fastfetch --logo /etc/nixos/avatar.png";

    # Plasma Manager Config


    plasma = {
      powerdevil.AC = {
        powerProfile = "performance";
        dimDisplay.idleTimeout = 600;
        turnOffDisplay.idleTimeout = 900;
      };

      workspace = {
        theme = "breeze-dark";
        iconTheme = "kora";
        #cursor.theme = "oreo_spark_violet_cursors";
        #cursor.size = "32";
        lookAndFeel = "Catppuccin.Mocha";
        windowDecorations.theme = "__aurorae__svg__Carl";
        windowDecorations.library = "org.kde.kdecoration2";
        splashScreen.theme = "Catppuccin.Mocha";
        colorScheme = "CatppuccinMocha";
      };

      kwin = {
        effects.shakeCursor.enable = false;
      };

      kscreenlocker.timeout = 900;
    };
  };
    gtk = {
    enable = true;
    iconTheme = {
      name = "kora";
    package = pkgs.kora-icon-theme;
  };
    };
}
