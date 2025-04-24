# ========================
# Plugin Configuration
# ========================

# Fisher: Plugin manager for Fish
if not type -q fisher
    echo "Fisher non trovato, lo installo con Homebrew..."
    brew install fisher
end

# Install plugins via Fisher
fisher install \
    PatrickF1/fzf.fish \
    PatrickF1/fish-autosuggestions \
    PatrickF1/fish-highlight

# ========================
# Environment Configuration
# ========================

# Node.js via FNM (Fast Node Manager)
if type -q fnm
    fnm env --use-on-cd | source
end

# Java via SDKMAN!
set -gx SDKMAN_DIR $HOME/.sdkman
if test -s "$SDKMAN_DIR/bin/sdkman-init.sh"
    bass source "$SDKMAN_DIR/bin/sdkman-init.sh"
    set -gx CURRENT_JAVA_VERSION (sdk current java | awk '{print $NF}')
    set -gx JAVA_HOME "$HOME/.sdkman/candidates/java/current"
end

# Add custom directories to PATH
fish_add_path $HOME/.filen-cli/bin
fish_add_path /opt/homebrew/opt/file-formula/bin

# Rust toolchain integration
if type -q rustup
    rustup toolchain link system (brew --prefix rust)
end

# Starship prompt initialization
if type -q starship
    starship init fish | source
end

# Zoxide: smarter cd
if type -q zoxide
    zoxide init fish | source
end

# ========================
# Aliases
# ========================

# Update all Homebrew packages
function update-all
    brew update; and brew upgrade; and brew cleanup
end

# Uninstall Spyder
function uninstall-spyder
    $HOME/Library/spyder-6/uninstall-spyder.sh
end
