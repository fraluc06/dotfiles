# ========================
# User Configuration
# ========================

# --- Plugin Configuration via Homebrew ---

# Zsh Autosuggestions
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Zsh Syntax Highlighting
# (IMPORTANTE: deve essere caricato per ultimo tra i plugin)
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# FZF (Keybindings + Completion)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ========================
# Environment Configuration
# ========================

# Node.js via FNM (used with `cd`)
eval "$(fnm env --use-on-cd)"

# Java via SDKMAN!
export SDKMAN_DIR="${HOME}/.sdkman"
[[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]] && source "${SDKMAN_DIR}/bin/sdkman-init.sh"
export CURRENT_JAVA_VERSION=$(sdk current java | awk '{print $NF}')
export JAVA_HOME="${SDKMAN_DIR}/candidates/java/current"

# Python PATH (uv)
export PATH="$HOME/.local/share/uv/python/cpython-3.13.3-macos-aarch64-none/bin:$PATH"

# CLI Tools (Filen CLI)
export PATH="${PATH}:${HOME}/.filen-cli/bin"

# Rust Toolchain (linked to Homebrew's Rust)
rustup toolchain link system "$(brew --prefix rust)"

# ========================
# Prompt and Navigation
# ========================

# Starship Prompt (via Homebrew)
eval "$(starship init zsh)"

# Zoxide (via Homebrew)
eval "$(zoxide init zsh)"

# ========================
# Aliases
# ========================

alias update-all='brew update && brew upgrade && brew cleanup'
alias uninstall-spyder="${HOME}/Library/spyder-6/uninstall-spyder.sh"
