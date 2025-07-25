{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    nix-gaming.url = "github:fufexan/nix-gaming";
    };


  outputs = { self, nixpkgs, chaotic, ... }@inputs: {
    # use "nixos", or your hostname as the name of the configuration
    # it's a better practice than "default" shown in the video
   nixosConfigurations.boreas = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
        chaotic.nixosModules.default # OUR DEFAULT MODULE
      ];
    };
  };
}

