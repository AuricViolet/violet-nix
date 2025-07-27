{ config, pkgs, ... }:
{

  home.stateVersion = "25.05"; # Your Home Manager state version
  home.username = "isolde";  # your user

  # Example of installing packages:
  home.packages = with pkgs; [
  ];
  #plasma manager
  programs = {
    bash.enable = true;
    bash.bashrcExtra = "fastfetch --logo /etc/nixos/avatar.png";
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
        cursor.theme = "oreo_spark_violet_cursors";
        cursor.size = "32";
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
