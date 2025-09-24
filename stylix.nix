{ pkgs, config, inputs, lib, nvf, stylix, ... }:
{
    stylix.enable = true;
    stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    stylix.cursor.package = pkgs.oreo-cursors-plus;
    stylix.cursor.name = "oreo_spark_violet_cursors";
    stylix.cursor.size = 32;
    stylix.opacity.terminal = 0.5;
    stylix.opacity.desktop = 0.5;
    }
