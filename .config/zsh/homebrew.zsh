# Check if Homebrew is installed, and if so, set up its environment variables
if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
