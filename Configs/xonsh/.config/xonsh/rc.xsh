import os

# ➤ Environment Variables
$XDG_CONFIG_HOME = os.path.expanduser("~/.config")
$TUCKR_HOME = os.path.expanduser("~")
$CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'

# ➤ Path updates
$PATH.append(os.path.expanduser("~/.lmstudio/bin"))
$PATH.insert(0, "/usr/local/bin")
$PATH.insert(0, "/opt/homebrew/bin") # Ensure homebrew is early in path

# ➤ fzf — Catppuccin Mocha
$FZF_DEFAULT_OPTS = " \
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#6C7086,label:#CDD6F4"

# ➤ Prompt Starship
execx($(starship init xonsh))

# ➤ zoxide (navigazione intelligente tra directory)
execx($(zoxide init xonsh), 'exec', __xonsh__.ctx, filename='zoxide')
# ➤ Carapace completions
execx($(carapace _carapace xonsh))

# ➤ mise-en place configuration
execx($(mise activate xonsh))

# ➤ Atuin (cronologia della shell avanzata)
execx($(atuin init xonsh))

# ➤ Conda initialization
# conda_exe = "/opt/anaconda3/bin/conda"
# if os.path.exists(conda_exe):
#     execx($({conda_exe} "shell.xonsh" "hook"))

# ➤ Aliases
aliases['update-all'] = 'brew update && brew upgrade && brew cleanup'
# aliases['ls'] = 'eza'
# aliases['ll'] = 'eza -lA --icons --group-directories-first'
# aliases['la'] = 'eza -A --icons --group-directories-first'

# ➤ Xonsh specific settings
$XONSH_PROMPT_AUTO_SUGGEST = True
$COMPLETIONS_CONFIRM = True
$CASE_SENSITIVE_COMPLETIONS = False
$VI_MODE = False # Set to True if you prefer vi keys
