# ➤ 1. CRITICAL: Convert System PATH string to a List
# Without this, prepend fails because it receives a string, not a list.
$env.PATH = ($env.PATH | split row (char esep))

# ➤ Set Homebrew prefix
$env.HOMEBREW_PREFIX = "/opt/homebrew"

# Add Homebrew to PATH
$env.PATH = ($env.PATH | prepend $"($env.HOMEBREW_PREFIX)/bin")
$env.PATH = ($env.PATH | prepend $"($env.HOMEBREW_PREFIX)/sbin")

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
