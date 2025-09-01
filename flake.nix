{
  # Based on librephoenix/nixos-config
  description = "Gege's flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/nur";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    stylix.url = "github:danth/stylix";
    # until https://github.com/nix-community/home-manager/issues/1341 is fixed
    # until https://github.com/nix-darwin/nix-darwin/pull/1396 is fixed
    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
    ...
  }:
    with import ./settings.nix; let
      profile = systemSettings.profile;
      commonArgs = {
        system = systemSettings.system;
        config.allowUnfree = true;
        overlays = [
          inputs.nur.overlays.default
          (final: prev: {
            oranchelo-icon-theme = prev.oranchelo-icon-theme.overrideAttrs {
              # FIXME: https://github.com/NixOS/nixpkgs/issues/380279
              dontCheckForBrokenSymlinks = true;
            };
          })
        ];
      };
      pkgs = import nixpkgs commonArgs;
    in {
      nixosConfigurations = {
        ${systemSettings.hostname} = nixpkgs.lib.nixosSystem {
          inherit pkgs;
          specialArgs = {
            inherit inputs userSettings systemSettings;
          };
          modules = [./profiles/${profile}/configuration.nix];
        };
      };
      homeConfigurations = {
        ${userSettings.username} = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit inputs userSettings systemSettings;
          };
          modules = [./profiles/${profile}/home.nix];
        };
      };
      darwinConfigurations = {
        ${systemSettings.hostname} = nix-darwin.lib.darwinSystem {
          inherit pkgs;
          specialArgs = {
            inherit inputs self userSettings systemSettings;
          };
          modules = [./profiles/${profile}/configuration.nix];
        };
      };
    };
}
