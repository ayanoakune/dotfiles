{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  # System packages (packages from nixpkgs)
  environment.systemPackages = [
    pkgs.bun
    pkgs.fnm
    pkgs.fzf
    pkgs.git
    pkgs.gnupg
    pkgs.lua
    pkgs.mkalias
    pkgs.neovim
    pkgs.pinentry_mac
    pkgs.pnpm
    pkgs.starship
    pkgs.stow
    pkgs.tmux
    pkgs.vim
    pkgs.yt-dlp
    pkgs.zulu17 # Java 17
  ];

  # Enable Homebrew and configure Homebrew casks
  homebrew = {
    enable = true;

    # Homebrew casks
    casks = [
      "alt-tab"
      "arc"
      "curseforge"
      "firefox"
      "font-jetbrains-mono"
      "google-chrome"
      "hoppscotch"
      "iterm2"
      "microsoft-teams"
      "nordvpn"
      "ollama"
      "orbstack"
      "rectangle"
      "steam"
      "visual-studio-code"
      "zen-browser"
    ];

    # App Store applications. Id is acquired from the URL.
    masApps = {
      "Affinity Photo 2" = 1616822987;
      "Davinci Resolve" = 571213070;
    };
  };

  # Fonts
  fonts.packages = [
    pkgs.nerd-fonts.hack
    pkgs.nerd-fonts.jetbrains-mono
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
