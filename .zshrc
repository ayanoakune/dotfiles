# Aliases
alias ls="eza --color=always --long --git --icons=always --time-style=relative --no-user --octal-permissions --no-permissions"
alias nix-rebuild="darwin-rebuild switch --flake ~/.dotfiles/nix#akune"
alias stow-dot="stow -d ~/.dotfiles -t ~ --ignore=nix --ignore=iterm ."

# Source zsh configurations
source ~/.config/zsh/history.zsh
source ~/.config/zsh/fzf.zsh
source ~/.config/zsh/gpg.zsh
source ~/.config/zsh/git.zsh
source ~/.config/zsh/homebrew.zsh
source ~/.config/zsh/zinit.zsh
source ~/.config/zsh/completion.zsh
source ~/.config/zsh/bat.zsh

# Use fnm - Fast Node Manager
eval "$(fnm env --use-on-cd --shell zsh)"

# Use Starship prompt # https://starship.rs
eval "$(starship init zsh)"

# Use Zoxide - Smarter cd command
eval "$(zoxide init --cmd cd zsh)"
