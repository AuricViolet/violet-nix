{ pkgs, config, inputs, lib, nixvim, ... }:
{
    programs.nixvim= {
    colorschemes.nightfox.enable = true;
    colorschemes.nightfox.autoLoad = true;
    colorschemes.nightfox.flavor = "duskfox";
    plugins = {
        nix-develop.enable = true;
        lualine.enable = true;
        comment.enable = true;
        dotnet.enable = true;
    };

    };
}
