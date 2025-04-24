# ========================
# User Configuration
# ========================

# Plugins
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Node.js via FNM (used with `cd`)
eval "$(fnm env --use-on-cd)"

# Java via SDKMAN!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
export CURRENT_JAVA_VERSION=$(sdk current java | awk '{print $NF}')
export JAVA_HOME="$HOME/.sdkman/candidates/java/current"

# CLI tools
export PATH="$PATH:$HOME/.filen-cli/bin:/opt/homebrew/opt/file-formula/bin"

# Rust toolchain
rustup toolchain link system "$(brew --prefix rust)"

# Starship prompt
eval "$(starship init zsh)"

# -- ALIASES --
alias update-all='brew update && brew upgrade && brew cleanup'
# Spyder alias
alias uninstall-spyder="$HOME/Library/spyder-6/uninstall-spyder.sh"

# Syntax Highlighting (must be at the end)
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
