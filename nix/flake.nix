{
  description = "Zenful nix-darwin system flake";

  inputs = {
    # Unstable packages
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # Nix Darwin
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Homebrew
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    homebrew-bundle.url = "github:homebrew/homebrew-bundle";
    homebrew-core.url = "github:homebrew/homebrew-core";
    homebrew-cask.url = "github:homebrew/homebrew-cask";
  };

  outputs = { self, nixpkgs, nix-darwin, nix-homebrew, home-manager, ... }:
    let
      system = "aarch64-darwin"; # MacOS on Apple Silicon
    in {
      darwinConfigurations.akune = nix-darwin.lib.darwinSystem {
        system = system;
        modules = [
          ./darwin.nix # Include darwin.nix for system configuration
          nix-homebrew.darwinModules.nix-homebrew
        ];
      };

      homeConfigurations.akune = home-manager.lib.homeManagerConfiguration {
        system = system;
        modules = [
          ./home.nix # Include home.nix for Home Manager configuration
        ];
      };
    };
}
