# ========================
# Plugin Configuration
# ========================

# Fisher: Plugin manager for Fish
# if not type -q fisher
#    echo "Fisher non trovato, lo installo con Homebrew..."
#    brew install fisher
# end

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
    replay source "$SDKMAN_DIR/bin/sdkman-init.sh"
    if type -q sdk
        set -gx CURRENT_JAVA_VERSION (sdk current java | awk '{print $NF}')
        set -gx JAVA_HOME "$HOME/.sdkman/candidates/java/current"
    end
end

# Aggiungi directory personalizzate alla variabile PATH
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

# Disattiva greeting
set -g fish_greeting ''

# ========================
# Functions
# ========================

# Wrapper per usare SDKMAN! in Fish
function sdk
    replay source "$HOME/.sdkman/bin/sdkman-init.sh" ';' sdk $argv
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

# Zoxide initialization
if type -q zoxide
    zoxide init fish | source
end
