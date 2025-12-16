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

# ➤ Git shortcuts
alias g = git
alias gs = git status
alias ga = git add
alias gc = git commit
alias gcm = git commit -m
alias gco = git checkout
alias gb = git branch
alias gl = git log --oneline --graph --all
alias gd = git diff
alias gp = git push
alias gl = git pull
alias gr = git restore

# Create .stow-global-ignore if it doesn't exist
if not ($"($env.HOME)/.stow-global-ignore" | path exists) {
    "\\.DS_Store" | save -f $"($env.HOME)/.stow-global-ignore"
}

# ➤ Load carapace completions
source $"($nu.cache-dir)/carapace.nu"

# Disable welcome banner
$env.config = ($env.config | upsert show_banner false)

# ➤ Load zoxide
source ~/.zoxide.nu

# ➤ Load atuin
source ~/.local/share/atuin/init.nu

# ➤ Load starship prompt
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")