# Aliases
alias ls="ls -G"
alias nix-rebuild="darwin-rebuild switch --flake ~/.dotfiles/nix#nyx"

# Use fnm - Fast Node Manager
eval "$(fnm env --use-on-cd --shell zsh)"

# Use Starship prompt # https://starship.rs
eval "$(starship init zsh)"
