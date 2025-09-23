{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    chaotic.url = "github:chaotic-cx/nyx/4cf82d519584e8420b32aa1ca48379987bbe4b2d";
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
     plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
      };
    };



  outputs = { self, nixpkgs, chaotic, home-manager, plasma-manager, nvf, stylix, ... }@inputs: {
    # use "nixos", or your hostname as the name of the configuration
    # it's a better practice than "default" shown in the video
   nixosConfigurations.boreas = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        nvf.nixosModules.default
        ./configuration.nix
        chaotic.nixosModules.default
        inputs.stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager{
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.sharedModules = [
          plasma-manager.homeModules.plasma-manager
          ];
          home-manager.users.isolde = {
          imports = [
            ./home.nix
            ];
          };
        }
      ];
        specialArgs = {inherit inputs;};
    };
  };
}

