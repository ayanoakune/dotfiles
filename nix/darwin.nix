{ config, pkgs, nix-homebrew, homebrew-bundle, homebrew-core, homebrew-cask, ... }:

{
  nixpkgs.config.allowUnfree = true;

  # System packages (packages from nixpkgs)
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
    pkgs.yt-dlp
    pkgs.zulu17 # Java 17
  ];

  # Enable Homebrew and configure Homebrew casks
  nix-homebrew = {
    enable = true;

    taps = {
        "homebrew/homebrew-core" = homebrew-core;
        "homebrew/homebrew-cask" = homebrew-cask;
        "homebrew/homebrew-bundle" = homebrew-bundle;
    };

    # Homebrew casks
    casks = [
      "alt-tab"
      "arc"
      "curseforge"
      "firefox"
      "iterm2"
      "nordvpn"
      "ollama"
      "orbstack"
      "rectangle"
      "steam"
      "visual-studio-code"
      "warp"
    ];
  };

  # Fonts
  fonts.packages = [
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono"]; })
  ];

  # MacOS system settings
  system.defaults = {
    dock.autohide = true;
    loginwindow.GuestEnabled = false;
    NSGlobalDomain.AppleICUForce24HourTime = true;
  };

  # Enable nix-daemon for flakes
  services.nix-daemon.enable = true;

  # Enable experimental flakes support
  nix.settings.experimental-features = "nix-command flakes";

  # Enable zsh
  programs.zsh.enable = true;

  # System state version for compatibility
  system.stateVersion = 5;
}
