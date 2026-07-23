{ config, lib,  pkgs, stylix, home-manager, ... }:
{
  
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    configType = "hyprlang";
    systemd = {
      enable = true;
      variables = [ "--all" ];
    }; 

    plugins = [
      pkgs.hyprland-protocols
    ];
    settings = {
      animations = {
      enabled = true;
    };
      decoration = {
        rounding = 20;
        rounding_power = 2;
        blur = {
          enabled = false;
          size = 3;
          passes = 2;
          vibrancy = 0.1696;
        };
      shadow = {
        enabled = false;
        range = 4;
        render_power = 3;
        color = lib.mkForce "0xee1a1a1a";
      };
      
      };
      "$mod" = "SUPER";

      general = {
        gaps_in = 5;
        gaps_out = 10;
        allow_tearing = true;
      };
      
      input = {
        follow_mouse = 1;
        accel_profile = "flat";
        sensitivity = 0.0;
        force_no_accel = true;
      };
      
      monitor = [
        "DP-3,2560x1440@180,0x0,1"
        "HDMI-A-1,1920x1080@60,2560x-200,1,transform,3"
      ];

      misc = {
        key_press_enables_dpms = true;
        mouse_move_enables_dpms = true;
        disable_hyprland_logo = true;
        animate_mouse_windowdragging = false;
        disable_splash_rendering = true;
        force_default_wallpaper = 0; 
        vrr = 1;
        
      };
      render = {
        direct_scanout = 1;
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
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE"  #"dbus-update-activation-environment --systemd --all"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE"#"systemctl --user import-environment"
        "easyeffects --gapplication-service"
        "noctalia"
        "vesktop"
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
          "$mod, R, exec, noctalia msg panel-toggle launcher" #fuzzel -w 30 -y 12 -f Roboto''-15 --line-height=20
          "$mod, B, togglefloating,"
          "$mod, E, exec, dolphin"
          "$mod, Q, killactive,"
          "$mod, L, exec, noctalia msg session lock" #previously hyprlock
          "$mod, H, exec, noctalia msg panel-toggle clipboard"
          "$mod, K, exec, noctalia msg media playPause"
          "$mod SHIFT, A, resizeactive, -30 0"
          "$mod SHIFT, D, resizeactive, 30 0"
          "$mod SHIFT, W, resizeactive, 0 -30"
          "$mod SHIFT, S, resizeactive, 0 30"

          ", F12, exec, grimblast copy area -f"
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
}