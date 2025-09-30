{ config, lib,  pkgs, stylix, home-manager, ... }:
{
  home.stateVersion = "25.05"; # Your Home Manager state version
  home.username = "isolde";    # your user

  # Example of installing packages:
  home.packages = with pkgs; [
    wofi
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
      on-resume = "waybar";
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
    enable = true;
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
          "$mod, R, exec, wofi --show drun --allow-images"
          "$mod, B, togglefloating,"
          "$mod, E, exec, kitty yazi"
          "$mod, Q, killactive,"
          "$mod, L, exec, hyprlock"

          "$mod SHIFT, A, resizeactive, -30 0"
          "$mod SHIFT, D, resizeactive, 30 0"
          "$mod SHIFT, W, resizeactive, 0 -30"
          "$mod SHIFT, S, resizeactive, 0 30"

          ", Print, exec, grimblast copy area -f"
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
    kitty = {
      enable = true;
      settings = {
        confirm_os_window_close = "0";
      };
    };
    waybar.enable = true;
    waybar.settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 20;
        modules-left = [ "network" ];
        modules-center = [ "hyprland/workspaces"  ];
        modules-right = [  "pulseaudio" "cava" "clock" ];
        persistent-workspaces = {
            "DP-1" = 1;
            "DVI-D-1" = 2;
          };
        "clock#time" = {
          format = "{:%p:%M}";
        };
        "network"= {
          interface = "wlo1";
          format = "{ifname}";
          format-wifi = "{essid} ({signalStrength}%) ";
          format-disconnected =  "";
          tooltip-format-wifi = "{essid} ({signalStrength}%) ";
          tooltip-format-disconnected = "Disconnected";
          max-length = 50;
          on-click = "exec kitty nmtui";
        };
        "cava"= {
          framerate = 60;
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
