{ pkgs, inputs, lib, ... }:
{
  home-manager.users.isolde = {
    # import the home manager module
    imports = [
      inputs.noctalia.homeModules.default
    ];
    programs.noctalia = {
      enable = true;
      systemd.enable = true;
      settings = {
        launch_apps_as_systemd_services = true;
        theme = {
          source = lib.mkForce "wallpaper";
        };
        wallpaper = {
          enabled = true;
          directory = "/etc/nixos/assets/wallpapers";
        };
    };
  };
};
}