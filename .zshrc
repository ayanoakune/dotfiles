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

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
setopt GLOB_DOTS

# Use fzf - Fuzzy finder
eval "$(fzf --zsh)"

# Use fnm - Fast Node Manager
eval "$(fnm env --use-on-cd --shell zsh)"

# Use Starship prompt # https://starship.rs
eval "$(starship init zsh)"

# Use Zoxide - Smarter cd command
eval "$(zoxide init --cmd cd zsh)"

# Configure Bat (cat alternative) theme
# You may need to run `bat cache --build` to refresh the cache
export BAT_THEME=tokyonight_night
