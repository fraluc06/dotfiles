#!/bin/zsh
# Interactive shell only. Environment (PATH, EDITOR, XDG, tuckr) lives in ~/.zshenv.

# ➤ Completion system
autoload -Uz compinit
compinit

# ➤ Completion UI
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'

# ➤ Carapace completions (official setup)
source <(carapace _carapace)

# ➤ Starship prompt
eval "$(starship init zsh)"

# ➤ fzf — Catppuccin Mocha, same palette reused by fzf-tab below
FZF_CATPPUCCIN=" \
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#6C7086,label:#CDD6F4"
export FZF_DEFAULT_OPTS=$FZF_CATPPUCCIN
zstyle ':fzf-tab:*' fzf-flags ${=FZF_CATPPUCCIN}
unset FZF_CATPPUCCIN
eval "$(fzf --zsh)"

# ➤ Antidote (zsh plugin manager) — plugins listed in ~/.zsh_plugins.txt
source "$HOMEBREW_PREFIX/opt/antidote/share/antidote/antidote.zsh"
antidote load "$HOME/.zsh_plugins.txt"

# ➤ fast-syntax-highlighting theme (~/.config/fsh, tuckr group "fsh")
# The plugin is deferred, so the theme is chained through zsh-defer too.
if [[ -r $XDG_CONFIG_HOME/fsh/catppuccin-mocha.ini ]] && (( $+functions[zsh-defer] )); then
  zsh-defer fast-theme -q XDG:catppuccin-mocha
fi

# ➤ mise (runtime version manager) — activate, not shims: env vars (GOROOT, GOBIN, …)
# and tool versions follow the directory; state must be recomputed at every prompt
eval "$(mise activate zsh)"

# ➤ zoxide (smarter cd that learns your habits)
eval "$(zoxide init zsh)"

# ➤ Atuin (enhanced shell history)
eval "$(atuin init zsh)"

# ➤ Aliases
alias ls='lsd'
alias ll='lsd -lA --group-directories-first'
alias la='lsd -A --group-directories-first'
alias update-all='brew update && brew upgrade && brew cleanup'
