{ pkgs, ... }:

let
  my-comfyui = pkgs.comfyuiPackages.comfyui.override {
    extensions = [
      pkgs.comfyuiPackages.extensions.acly-inpaint
      pkgs.comfyuiPackages.extensions.acly-tooling
      pkgs.comfyuiPackages.extensions.cubiq-ipadapter-plus
      pkgs.comfyuiPackages.extensions.fannovel16-controlnet-aux
    ];

    commandLineArgs = [
      "--preview-method"
      "auto"
    ];
  };
in

{
  environment.systemPackages = [
    my-comfyui
  ];
}
