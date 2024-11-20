# Dotfiles via GNU Stow & Nix package manager

This repository contains dotfiles and setup scripts for my personal development environment on MacOS/Darwin. Using [GNU Stow](https://www.gnu.org/software/stow/) to manage dotfiles and [Nix](https://nixos.org/) as package manager.

# Quick setup

1. Install [Nix package manager](https://nixos.org/download/):

```sh
sh <(curl -L https://nixos.org/nix/install)
```

2. Clone dotfiles (this) repository:

```sh
nix-shell -p git --run 'git clone git@github.com:ayanoakune/dotfiles.git .dotfiles'
```

3. Install packages and setup dotfiles:

```sh
nix run nix-darwin --extra-experimental-features 'nix-command flakes' -- switch --flake ~/.dotfiles/nix#nyx'
```
