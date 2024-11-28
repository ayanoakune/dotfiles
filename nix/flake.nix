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
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, home-manager, ... }:
  let
    configuration = { pkgs, config, ... }: {

      nixpkgs.config.allowUnfree = true;

      # https://search.nixos.org/packages
      environment.systemPackages = [
        pkgs.bun
        pkgs.fnm
        pkgs.git
        pkgs.gnupg
        pkgs.mkalias
        pkgs.neovim
        pkgs.pinentry_mac
        pkgs.pnpm
        pkgs.starship
        pkgs.stow
        pkgs.vim
      ];

      homebrew = {
        enable = true;
        onActivation.cleanup = "zap"; # Removes all Homebrew packages not in the flake.
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;

        # https://formulae.brew.sh/
        casks = [
          "alt-tab"
          "arc"
          "curseforge"
          "firefox"
          "nordvpn"
          "orbstack"
          "steam"
          "ollama"
          "visual-studio-code"
          "warp"
        ];

        # App Store applications. Id is acquired from the URL.
        masApps = {
          "Affinity Photo 2" = 1616822987;
          "Davinci Resolve" = 571213070;
        };
      };

      fonts.packages = [
        (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono"]; })
      ];

      # Set up applications in /Applications, so they are accessible from the
      # dock and spotlight.
      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = "/Applications";
        };
      in
        pkgs.lib.mkForce ''
        # Set up applications.
        echo "setting up /Applications..." >&2
        rm -rf /Applications/Nix\ Apps
        mkdir -p /Applications/Nix\ Apps
        find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
        while read -r src; do
          app_name=$(basename "$src")
          echo "copying $src" >&2
          ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
        done
      '';

      # MacOS system settings.
      system.defaults = {
        dock.autohide = true;
        loginwindow.GuestEnabled = false;
        NSGlobalDomain.AppleICUForce24HourTime = true;
      };

      # Auto upgrade nix package and the deamon service.
      services.nix-daemon.enable = true;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      programs.zsh.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#nyx
    darwinConfigurations."nyx" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            # Install Homebrew under the default prefix
            enable = true;

            # Apple Silicon Only
            enableRosetta = true;

            # User owning the Homebrew prefix
            user = "akune";

            autoMigrate = true;
          };
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."nyx".pkgs;
  };
}
