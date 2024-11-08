{
  # Based on librephoenix/nixos-config
  description = "Gege's flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    stylix.url = "github:danth/stylix";
  };

  outputs =  inputs@{ self, nixpkgs, home-manager, ... }:
    with import ./settings.nix;
    let
      pkgs = nixpkgs.legacyPackages.${systemSettings.system};
      system = systemSettings.system;
      profile = systemSettings.profile;
    in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./profiles/${profile}/configuration.nix ];
      };
    };
    homeConfigurations = {
      gege =  home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs userSettings systemSettings;
        };
        modules = [ ./profiles/${profile}/home.nix ];
      };
    };
  };

}
