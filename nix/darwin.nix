{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  # System packages (packages from nixpkgs)
  environment.systemPackages = [
    pkgs.bat
    pkgs.bun
    pkgs.eza
    pkgs.fnm
    pkgs.fzf
    pkgs.git
    pkgs.git-interactive-rebase-tool
    pkgs.gnupg
    pkgs.lua
    pkgs.mkalias
    pkgs.neovim
    pkgs.nixpkgs-fmt
    pkgs.pinentry_mac
    pkgs.pnpm
    pkgs.starship
    pkgs.stow
    pkgs.tmux
    pkgs.vim
    pkgs.yt-dlp
    pkgs.zoxide
    pkgs.zulu17 # Java 17
  ];

  # Enable Homebrew and configure Homebrew casks
  homebrew = {
    enable = true;
    global = {
      brewfile = true;
      lockfiles = true;
    };

    # Homebrew casks
    casks = [
      "alt-tab"
      "arc"
      "bitwarden"
      "curseforge"
      "cursor"
      "ghostty"
      "firefox"
      "font-jetbrains-mono"
      "google-chrome"
      "hoppscotch"
      "iterm2"
      "mac-mouse-fix"
      "microsoft-teams"
      "nordvpn"
      "ollama"
      "orbstack"
      "raycast"
      "rectangle"
      "shottr"
      "steam"
      "visual-studio-code"
      "zen-browser"
    ];

    # App Store applications. Id is acquired from the URL.
    masApps = {
      "Affinity Photo 2" = 1616822987;
      "Davinci Resolve" = 571213070;
      "DigiDoc4" = 1370791134;
    };
  };

  # Fonts
  fonts.packages = [
    pkgs.nerd-fonts.hack
    pkgs.nerd-fonts.jetbrains-mono
  ];

  # MacOS system settings
  system.defaults = {
    dock = {
      autohide = true;
      autohide-delay = 0.0;
      autohide-time-modifier = 0.5;
      show-recents = false;
      minimize-to-application = true;
      mru-spaces = false;
    };

    finder = {
      AppleShowAllExtensions = true;
      FXEnableExtensionChangeWarning = false;
      _FXShowPosixPathInTitle = true;
      FXPreferredViewStyle = "Nlsv";
    };

    loginwindow.GuestEnabled = false;

    NSGlobalDomain = {
      AppleICUForce24HourTime = true;
      ApplePressAndHoldEnabled = false;
      InitialKeyRepeat = 10;
      KeyRepeat = 2;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
    };
  };

  # Enable experimental flakes support
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  # Enable zsh
  programs.zsh.enable = true;

  # System state version for compatibility
  system.stateVersion = 5;
}
