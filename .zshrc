# Aliases
alias ls="ls -G"
alias nix-rebuild="darwin-rebuild switch --flake ~/.dotfiles/nix#nyx"

# Use Starship prompt # https://starship.rs
eval "$(starship init zsh)"
