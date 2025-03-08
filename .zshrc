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
source ~/.config/zsh/fnm.zsh
source ~/.config/zsh/starship.zsh
source ~/.config/zsh/zoxide.zsh
