# ➤ 1. CRITICAL: Convert System PATH string to a List
# Without this, prepend fails because it receives a string, not a list.
$env.PATH = ($env.PATH | split row (char esep))

# ➤ Set Homebrew prefix
$env.HOMEBREW_PREFIX = "/opt/homebrew"

# Add Homebrew to PATH
$env.PATH = ($env.PATH | prepend $"($env.HOMEBREW_PREFIX)/bin")
$env.PATH = ($env.PATH | prepend $"($env.HOMEBREW_PREFIX)/sbin")

# ➤ Install SDKMAN! if it doesn't exist
# let sdkman_dir = $"($env.HOME)/.sdkman"
# if not ($sdkman_dir | path exists) {
#     print "📦 Installing SDKMAN..."
#     curl -s "https://get.sdkman.io" | bash
# }

# ➤ Initialize SDKMAN!
# $env.SDKMAN_DIR = $sdkman_dir
# let sdkman_init = $"($env.SDKMAN_DIR)/bin/sdkman-init.sh"
# if ($sdkman_init | path exists) {
#     # SDKMAN! initialization
#     $env.JAVA_HOME = $"($env.SDKMAN_DIR)/candidates/java/current"

#     # Add SDKMAN! to PATH
#     $env.PATH = ($env.PATH | prepend $"($env.SDKMAN_DIR)/bin")

#     # Set SDKMAN! candidates directory
#     $env.SDKMAN_CANDIDATES_DIR = $"($env.SDKMAN_DIR)/candidates"

#     # FIXED: SDKMAN loop logic
#     # 'ls' returns full paths, so we use 'path basename' to get just the candidate name
#     let candidates = (ls $env.SDKMAN_CANDIDATES_DIR | where type == dir)
#     for candidate in $candidates {
#         let candidate_name = ($candidate.name | path basename)
#         let current_dir = $"($env.SDKMAN_CANDIDATES_DIR)/($candidate_name)/current/bin"
#         if ($current_dir | path exists) {
#             $env.PATH = ($env.PATH | prepend $current_dir)
#         }
#     }
# }

# ➤ conda initialization
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

$env.PATH = ($env.PATH | split row (char esep) | prepend '/Library/TeX/texbin')
# History configuration
$env.HISTORY_SIZE = 10000
$env.HISTORY_FILE_SIZE = 1000000

# ➤ Carapace for advanced completions
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'
mkdir $"($nu.cache-dir)"
carapace _carapace nushell | save --force $"($nu.cache-dir)/carapace.nu"

# ➤ Load zoxide initialization
zoxide init nushell | save -f ~/.zoxide.nu

# Aggiunta di rbenv al PATH
$env.PATH = ($env.PATH | split row (char esep) | prepend '~/.rbenv/shims')
# ➤ Mise en place
let mise_path = $nu.default-config-dir | path join mise.nu
^mise activate nu | save $mise_path --force
