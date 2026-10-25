eval "$(/opt/homebrew/bin/brew shellenv)"

# /etc/zprofile runs path_helper, which rebuilds PATH from the system dirs:
# restore the entries added by ~/.zshenv (typeset -U keeps them unique)
path=("$HOME/.local/bin" $path)

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
