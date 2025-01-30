# Dotfiles via GNU Stow & Nix package manager

This repository contains dotfiles and setup scripts for my personal development environment on MacOS/Darwin. Using [GNU Stow](https://www.gnu.org/software/stow/) to manage dotfiles and [Nix](https://nixos.org/) as package manager.

## Initial setup

1. Install [Nix package manager](https://nixos.org/download/):

```sh
sh <(curl -L https://nixos.org/nix/install)
```

2. Clone dotfiles (this) repository in your home directory:

```sh
nix-shell -p git --run 'git clone git@github.com:ayanoakune/dotfiles.git .dotfiles'
```

3. Install packages and setup dotfiles:

```sh
nix run nix-darwin --extra-experimental-features 'nix-command flakes' -- switch --flake ~/.dotfiles/nix#akune'
```

4. Create symlinks with dotfiles via GNU Stow:

```sh
stow -d ~/.dotfiles -t ~ --ignore=nix .
```

## Helpful commands

After [initial setup](#initial-setup), you can use the following commands:

- `nix-rebuild` - Rebuild Nix configuration.
- `stow-dot` - Create symlinks with dotfiles via GNU Stow.

## Updating Git configuration

> [!NOTE]
> This solution is bit wonky. Be careful when updating `personal` file. Check if it's being tracked by Git.


`personal` configuration file should be updated with your personal information (email, username etc).

To prevent Git from tracking changes to this file, run the following command:

```sh
git update-index --assume-unchanged .config/git/personal
```

To revert the change, use the following command:

```sh
git update-index --no-assume-unchanged .config/git/personal
```
