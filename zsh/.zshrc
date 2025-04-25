# ========================
# User Configuration
# ========================

# --- Zplug Initialization ---
export ZPLUG_HOME="${HOME}/.zplug"
source "${ZPLUG_HOME}/init.zsh"

# --- Plugin Management ---
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "junegunn/fzf", use:"shell/*.zsh", defer:1

# Install plugins if not already installed
if ! zplug check --verbose; then
  zplug install
fi

# Load plugins
zplug load

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

# Python PATH
export PATH="$HOME/.local/share/uv/python/cpython-3.13.3-macos-aarch64-none/bin:$PATH"

# CLI Tools
export PATH="${PATH}:${HOME}/.filen-cli/bin"

# Rust Toolchain
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
