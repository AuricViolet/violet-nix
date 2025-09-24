{ config, pkgs, stylix, home-manager, ... }:
{
    imports = [
    ];

    wayland.windowManager.hyprland.systemd.variables = ["--all"];
    wayland.windowManager.hyprland.systemd.enable = true;
    wayland.windowManager.hyprland.plugins = [
    pkgs.hyprlandPlugins.hyprbars
    pkgs.hyprlandPlugins.hyprfocus
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = null;
    portalPackage = null;
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
    # Launch on startup.
     exec-once = [        ""
      "mako"
      "waybar"
      "vesktop"
    ];
    # Mouse and Keyboard Bindings -
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
    bind = [

        "$mod, A, movewindow, l"
        "$mod, D, movewindow, r"
        "$mod, W, movewindow, u"
        "$mod, S, movewindow, d"


        "$mod, F, fullscreen"
        "$mod, T, exec, kitty"
        "$mod, R, exec, wofi --show drun --allow-images"
        "$mod, B,  togglefloating,"
        "$mod, E, exec, kitty yazi"
        "$mod, Q, killactive,"

        "$mod SHIFT, A, resizeactive, -10 0"
        "$mod SHIFT, D, resizeactive, 10 0"
        "$mod SHIFT, W, resizeactive, 0 -10"
        "$mod SHIFT, S, resizeactive, 0 10"

        ", Print, exec, grimblast copy area"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
          9)
      );
  };
};
}
