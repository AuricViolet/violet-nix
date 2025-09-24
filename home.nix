{ config, pkgs, stylix, home-manager, ... }:
{

  home.stateVersion = "25.05"; # Your Home Manager state version
  home.username = "isolde";  # your user

  # Example of installing packages:
  home.packages = with pkgs; [
  wofi
  mako
  hyprpaper
  waybar
  vesktop
  ];
  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
  };

  services.network-manager-applet.enable = true;
  services.hyprpaper= {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;
      preload = ["/home/isolde/Pictures/walls/druid.jpg"];
      wallpaper = [", /home/isolde/Pictures/walls/druid.jpg"];
  };
};
  wayland.windowManager.hyprland.systemd.variables = ["--all"];
  wayland.windowManager.hyprland.systemd.enable = true;
    wayland.windowManager.hyprland.plugins = [
    pkgs.hyprlandPlugins.hyprbars
    pkgs.hyprlandPlugins.hyprfocus
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
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
     exec-once = [        ""
      "mako"
      "waybar"
      "vesktop"
    ];
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





  #plasma manager stuff for kde6
  programs = {
    kitty = {
      enable = true;
      settings = {
        confirm_os_window_close = "0";
    };
  };
    waybar.enable = true;
    waybar.settings =
    {
    mainBar = {
      layer = "top";
      position = "top";
      height = 20;
      modules-left = ["cpu" "network" "temperature"];
      modules-center = [ "workspaces" ];
      modules-right = ["pulseaudio" "clock"];




    };
    #shell & startup
    bash.enable = true;
    bash.bashrcExtra = "fastfetch --logo /etc/nixos/avatar.png";
    # Plamsa Manager Config
    plasma = {
      #powerdevil.AC = {
        #powerProfile = "performance";
        #dimDisplay.idleTimeout = 600;
        #turnOffDisplay.idleTimeout = 900;
      #};

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

      kwin ={
        effects.shakeCursor.enable = false;
    };
    kscreenlocker.timeout = 900;
    kscreenlocker.appearance.wallpaperSlideShow.path = "/home/isolde/Pictures/walls/walls-catppuccin-mocha/";

  };
  };
}
