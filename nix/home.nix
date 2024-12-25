{ config, pkgs, ... }:

{
  home.stateVersion = "23.11"; # Set the version for compatibility
  home.homeDirectory = "/Users/akune"; # Specify the correct home directory path

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "zsh-autosuggestions" "zsh-syntax-highlighting" ];
    };
  };
}
