# Aliases
alias ls="ls -G"
alias nix-rebuild="darwin-rebuild switch --flake ~/.dotfiles/nix#akune"
alias stow-dot="stow -d ~/.dotfiles -t ~ --ignore=nix ."

# Set the GPG_TTY to be the same as the TTY, either via the env var
# or via the tty command.
if [ -n "$TTY" ]; then
  export GPG_TTY=$(tty)
else
  export GPG_TTY="$TTY"
fi

# Use custom location for the global Git configuration file
# Personal config file is located in ~/.config/git/personal and not tracked
# via Git.
export GIT_CONFIG_GLOBAL=~/.config/git/config

# Check if Homebrew is installed, and if so, set up its environment variables
if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

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
