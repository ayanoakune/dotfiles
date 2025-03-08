# Preview configuration for files and directories
show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

# Default fzf options
export FZF_DEFAULT_OPTS="
  --height 80%
  --layout=reverse
  --border
  --margin=1
  --padding=1
  --color=bg+:#292e42,bg:#1a1b26,spinner:#bb9af7,hl:#ff9e64
  --color=fg:#c0caf5,header:#7aa2f7,info:#7dcfff,pointer:#bb9af7
  --color=marker:#9ece6a,fg+:#c0caf5,prompt:#bb9af7,hl+:#ff9e64
"

# Configure fzf options for Ctrl+T (files and directories)
export FZF_CTRL_T_OPTS="
  --preview '$show_file_or_dir_preview'
  --preview-window 'right:60%:wrap'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'
"

# Configure fzf options for Alt+C (cd)
export FZF_ALT_C_OPTS="
  --preview 'eza --tree --color=always {} | head -200'
  --preview-window 'right:60%:wrap'
"

# Configure fzf default command to use fd if available
if command -v fd > /dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND='fd --type f --type d --hidden --follow --exclude .git'
fi

# Configure fzf completion preview behavior
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo ${}'" "$@" ;;
    ssh)          fzf --preview 'dig {}' "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# Initialize fzf
eval "$(fzf --zsh)"

# Key bindings
# ctrl-r - Search command history
# ctrl-t - Search for files and directories
# alt-c  - CD into selected directory
