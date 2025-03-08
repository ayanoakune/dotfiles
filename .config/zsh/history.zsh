# History file configuration
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE

# History options
setopt appendhistory    # Append to history file
setopt sharehistory    # Share history between sessions
setopt hist_ignore_space    # Don't record commands starting with space
setopt hist_ignore_all_dups # Remove older duplicate entries
setopt hist_save_no_dups    # Don't save duplicates
setopt hist_ignore_dups     # Don't record duplicate commands
setopt hist_find_no_dups    # Don't display duplicates when searching
