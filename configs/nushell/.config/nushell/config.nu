# ➤ CRITICAL: Convert System PATH string to a List
# Without this, prepend fails because it receives a string, not a list.
# $env.PATH = ($env.PATH | split row (char esep))

# ➤ Set Homebrew prefix
$env.HOMEBREW_PREFIX = "/opt/homebrew"

# Add Homebrew to PATH
$env.PATH = ($env.PATH | prepend $"($env.HOMEBREW_PREFIX)/bin")
$env.PATH = ($env.PATH | prepend $"($env.HOMEBREW_PREFIX)/sbin")

# OrbStack PATH
$env.PATH = ($env.PATH | prepend ($env.HOME | path join ".orbstack/bin"))

# ➤ Mullvad VPN CLI (per comando 'mullvad')
$env.PATH = ($env.PATH | prepend '/usr/local/bin')

# ➤ TeX Live PATH
$env.PATH = ($env.PATH | split row (char esep) | prepend '/Library/TeX/texbin')

# ➤ Add LM Studio CLI to PATH
let lmstudio_path = "/Users/francesco/.lmstudio/bin"
if ($lmstudio_path | path exists) {
    $env.PATH = ($env.PATH | prepend $lmstudio_path)
}

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

# Tuckr directory
$env.TUCKR_HOME = ($env.HOME | path join "dotfiles")

# Disable welcome banner
$env.config = ($env.config | upsert show_banner false)

# Catppuccin Mocha theme colors
$env.FZF_DEFAULT_OPTS = $"
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8
--color=selected-bg:#45475A
--color=border:#6C7086,label:#CDD6F4
"

# ➤ Update all Homebrew packages
def update-all [] {
    brew update
    brew upgrade
}

# Open alias to avoid conflict with nu's open command
alias nu-open = open
alias open = ^open

# Set default editor to Zed
$env.EDITOR = 'zed'

# ➤ Load carapace completions
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'
mkdir ($nu.data-dir | path join "vendor/autoload")
carapace _carapace nushell | save -f ($nu.data-dir | path join "vendor/autoload/carapace.nu")

# ➤ Load zoxide
mkdir ($nu.data-dir | path join "vendor/autoload")
zoxide init nushell | save -f ($nu.data-dir | path join "vendor/autoload/zoxide.nu")

# ➤ Load atuin
mkdir ($nu.data-dir | path join "vendor/autoload")
atuin init nu | save -f ($nu.data-dir | path join "vendor/autoload/init.nu")

# ➤ Load starship prompt
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

# ➤ Load mise-en place configuration
mkdir ($nu.data-dir | path join "vendor/autoload")
^mise activate nu | save -f ($nu.data-dir | path join "vendor/autoload/mise.nu")

# History configuration
$env.HISTORY_SIZE = 10000
$env.HISTORY_FILE_SIZE = 1000000