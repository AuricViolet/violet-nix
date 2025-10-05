{ config, lib,  pkgs, stylix, home-manager, ... }:
{
  home.stateVersion = "25.05"; # Your Home Manager state version
  home.username = "isolde";    # your user

  # Example of installing packages:
  home.packages = with pkgs; [
    #wofi
    hyprpaper
    waybar
    cava
  ];

  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    WLR_DRM_DEVICES = "$HOME/.config/hypr/card";
    AQ_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card2";
    XDG_MENU_PREFIX = "plasma-";
  };

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
      pkgs.hyprlandPlugins.hyprfocus
    ];

    settings = {
      "$mod" = "SUPER";


      monitor = [
        "DP-1,2560x1440@180,0x0,1"
        "DVI-D-1,1920x1080@144,2560x250,1"
      ];

      misc = {
        key_press_enables_dpms = true;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

       workspace = [
      "1,monitor:DP-1,default:true"
      "2,monitor:DP-1"
      "3,monitor:DP-1"
      "4,monitor:DP-1"
      "5,monitor:DP-1"

      "6,monitor:DVI-D-1,default:true"
      "7,monitor:DVI-D-1"
      "8,monitor:DVI-D-1"
      "9,monitor:DVI-D-1"
      "10,monitor:DVI-D-1"
    ];

      exec-once = [
        "mako"
        "waybar"
        "vesktop"
        "wl-paste --watch cliphist store"
        ''mpvpaper ALL -o "no-audio --loop-file='inf'" /home/isolde/Videos/window.mp4''
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bind =
        [
          "$mod, A, movewindow, l"
          "$mod, D, movewindow, r"
          "$mod, W, movewindow, u"
          "$mod, S, movewindow, d"

          "$mod, F, fullscreen"
          "$mod, T, exec, kitty"
          "$mod, R, exec, wofi --show drun -e --allow-images -H 300 -W 300"
          "$mod, B, togglefloating,"
          "$mod, E, exec, dolphin"
          "$mod, Q, killactive,"
          "$mod, L, exec, hyprlock"
          "$mod, H, exec, cliphist list | wofi -S dmenu | cliphist decode | wl-copy"

          "$mod SHIFT, A, resizeactive, -30 0"
          "$mod SHIFT, D, resizeactive, 30 0"
          "$mod SHIFT, W, resizeactive, 0 -30"
          "$mod SHIFT, S, resizeactive, 0 30"

          ", Print, exec, grimblast copy area -f"
          "$mod, Print, exec, notify-send '🎥 Recording started' && wf-recorder -f ~/Videos/WFrecorder/recording-$(date +'%Y-%m-%d_%H-%M-%S').mp4 -r 60 -g \"$(slurp)\" -c h264_nvenc"
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
  yazi = {
    enable = true;
  };


  hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = false;
        ignore_empty_input = true;
    };
    background = {
      path = "/home/isolde/Pictures/walls/druid.jpg";
      blur_passes = 1;
      blur_size = 8;
    };
    label = {
      monitor = "DP-1";
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
      monitor = "DP-1";
      shadow_passes = 2;
      outline_thickness = 5;
      rounding = 1;
    };
  };
};
    wofi.enable = true;
    wofi.settings = {
      prompt = "";
    };
    wofi.style = ''
    window {
      border-radius: 12px;
      border: 5px solid #cba6f7;
      background-color: rgba(30, 30, 46, 0.95);
      color: #cdd6f4;
    }
    #outer-box {
      border-radius: 12px;
      border: 5px solid #cba6f7;
      background-color: rgba(30, 30, 46, 0.95);
      color: #cdd6f4;
    }

    #entry,
    #input {
      border-radius: 8px;
      background-color: rgba(30, 30, 46, 0.95);
      border: 2px solid #b4befe;
    }
    

    #input {
      margin: 5px;
      border: 1px solid #cba6f7;
      padding: 5px;
      background-color: rgba(49, 50, 68, 0.8);
      color: #cdd6f4;
    }

    #entry:selected {
      background-color: rgba(203, 166, 247, 0.3);
      border-radius: 6px;
    }
    '';
    
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
            "DP-1" = 1;
            "DVI-D-1" = 2;
          };
          
        "clock"= {
          format = "{:%I:%M %p}";
          tooltip-format = "{:%A, %B %d, %Y}";
        };
        "network"= {
          interface = "wlo1";
          format = "{ifname}";
          format-wifi = " ";
          format-disconnected =  "";
          tooltip-format-wifi = "{essid} ({signalStrength}%) ";
          tooltip-format-disconnected = "Disconnected";
          max-length = 25;
          on-click = "exec kitty nmtui";
        };
        "image"= {
          path = "/home/isolde/nixos/avatar.png";
          size = 25;
          on-click = "exec wofi --show drun -e -w 2 --allow-images -H 300 -W 300";
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
              color: #11111b;
          }

        #network {
          background: rgba(203, 166, 247, 0.75);
          border-radius: 6px;
          padding: 0 10px;
          color: #11111b;
          }

        #image {
          border-radius: 6px;
          margin: 0 3px;
        }

        #pulseaudio,
        #clock, 
        #cava,
        #workspaces {
          background: rgba(203, 166, 247, 0.75);
          border-radius: 6px;
          color: #11111b;
          padding: 0 3px;
          min-height: 0;
        }

        #workspaces button.visible {
          color: #11111b;        
        }
        
        #workspaces button.active {
          color: #cdd6f4;
        }
        #workspaces button.urgent {
          color: #f38ba8;
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
        wallpaperSlideShow = "/home/isolde/Pictures/walls/walls-catppuccin-mocha/";
        theme = "breeze-dark";
        iconTheme = "ColorFlow";
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
      kscreenlocker.appearance.wallpaperSlideShow.path =
        "/home/isolde/Pictures/walls/walls-catppuccin-mocha/";
    };
  };
}
