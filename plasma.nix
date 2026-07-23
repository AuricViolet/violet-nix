{ config, lib,  pkgs, home-manager, ... }:
{
  programs = {
    plasma = {
      powerdevil.AC = {
        powerProfile = "performance";
        dimDisplay.idleTimeout = 600;
        turnOffDisplay.idleTimeout = 900;
      };

      workspace = {
        theme = "breeze-dark";
        iconTheme = "kora";
        cursor.theme = "oreo_spark_violet_cursors";
        cursor.size = "32";
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
}