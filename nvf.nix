{ config, pkgs, lib, nvf, ... }:

{
  programs.nvf = {
    enable = true;
    # your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings = {
      
    };
  };
}