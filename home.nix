{ config, lib, inputs, pkgs, stylix, home-manager, ... }:
{
  imports = [
    ./hyprland.nix
    ./plasma.nix
  ];
  home.stateVersion = "26.05"; # Your Home Manager state version
  home.username = "isolde";    # your user

  home.packages = with pkgs; [
    waybar
    cava
    fuzzel
  ];
  home.sessionVariables = {
    LOW_LATENCY_LAYER= "1";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    QS_ICON_THEME = "kora";
  };
  xdg.enable = true;
  home.pointerCursor.enable = true;
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
    kitty = {
      enable = true;
      settings = {
        confirm_os_window_close = "0";
      };
    };
    
    # Shell & startup
    bash.enable = true;
    bash.bashrcExtra = "fastfetch --logo /etc/nixos/assets/avatar.png";

    };    
    gtk = {
    enable = true;
    iconTheme = {
      name = "kora";
    package = pkgs.kora-icon-theme;
  };
    };
}
