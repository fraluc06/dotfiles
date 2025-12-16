# ➤ Set Homebrew prefix
$env.HOMEBREW_PREFIX = "/opt/homebrew"

# Add Homebrew to PATH
$env.PATH = ($env.PATH | prepend $"($env.HOMEBREW_PREFIX)/bin")
$env.PATH = ($env.PATH | prepend $"($env.HOMEBREW_PREFIX)/sbin")

# ➤ Install SDKMAN! if it doesn't exist
let sdkman_dir = $"($env.HOME)/.sdkman"
if not ($sdkman_dir | path exists) {
    print "📦 Installing SDKMAN..."
    curl -s "https://get.sdkman.io" | bash
}

# ➤ Initialize SDKMAN!
$env.SDKMAN_DIR = $sdkman_dir
let sdkman_init = $"($env.SDKMAN_DIR)/bin/sdkman-init.sh"
if ($sdkman_init | path exists) {
    # SDKMAN! initialization (simplified for Nushell)
    # SDKMAN! doesn't have native Nushell support, so we set JAVA_HOME manually
    $env.JAVA_HOME = $"($env.SDKMAN_DIR)/candidates/java/current"

    # Add SDKMAN! to PATH
    $env.PATH = ($env.PATH | prepend $"($env.SDKMAN_DIR)/bin")

    # Set SDKMAN! candidates directory
    $env.SDKMAN_CANDIDATES_DIR = $"($env.SDKMAN_DIR)/candidates"

    # Add SDKMAN! candidates to PATH
    let candidates = (ls $"($env.SDKMAN_CANDIDATES_DIR)" | get name)
    for candidate in $candidates {
        let current_dir = $"($env.SDKMAN_CANDIDATES_DIR)/($candidate)/current/bin"
        if ($current_dir | path exists) {
            $env.PATH = ($env.PATH | prepend $current_dir)
        }
    }
}

# ➤ conda initialization
# Note: conda doesn't have native Nushell support, so we set PATH manually
let conda_path = "/opt/anaconda3/bin"
if ($conda_path | path exists) {
    $env.PATH = ($env.PATH | prepend $conda_path)
    $env.CONDA_EXE = $"($conda_path)/conda"
    $env.CONDA_PREFIX = "/opt/anaconda3"
    $env.CONDA_SHLVL = "1"
    $env.CONDA_DEFAULT_ENV = "base"
    $env.CONDA_PROMPT_MODIFIER = "(base) "
}

# Set default editor to Zed
$env.EDITOR = 'zed'

# ➤ Add LM Studio CLI to PATH
let lmstudio_path = "/Users/francesco/.lmstudio/bin"
if ($lmstudio_path | path exists) {
    $env.PATH = ($env.PATH | prepend $lmstudio_path)
}

# History configuration
$env.HISTORY_SIZE = 10000
$env.HISTORY_FILE_SIZE = 1000000

# ➤ Carapace for advanced completions
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir $"($nu.cache-dir)"
carapace _carapace nushell | save --force $"($nu.cache-dir)/carapace.nu"

# ➤ Load zoxide initialization
zoxide init nushell | save -f ~/.zoxide.nu