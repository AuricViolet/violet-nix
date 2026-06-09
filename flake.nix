{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    nixvim.url = "github:nix-community/nixvim";
    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
     plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
      };
    };



  outputs = { self, nixpkgs,nixpkgs-unstable, home-manager, plasma-manager,spicetify-nix,nixvim, stylix,
 ... }@inputs: {
   nixosConfigurations.boreas = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        inputs.stylix.nixosModules.stylix
        nixvim.nixosModules.nixvim
        ./configuration.nix
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
    specialArgs = {
      inherit inputs;
      nixpkgs-unstable = import inputs.nixpkgs-unstable {
      system = "x86_64-linux";
      config.allowUnfree = true;
  };
};
    };
  };
}

