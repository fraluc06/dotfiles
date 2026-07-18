#!/bin/zsh
# ➤ Homebrew on Apple Silicon (hard-coded to avoid a slow `brew --prefix` call)
export HOMEBREW_PREFIX="/opt/homebrew"

# ➤ Faster completion startup: reuse the cached .zcompdump, rebuild it at most once a day
autoload -Uz compinit
setopt EXTENDED_GLOB
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.m-1) ]]; then
  compinit -C
else
  compinit
fi
unsetopt EXTENDED_GLOB

# ➤ Starship prompt
eval "$(starship init zsh)"

# ➤ fzf (fuzzy finder for files, searches and history)
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
# fzf — Catppuccin Mocha theme
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#6C7086,label:#CDD6F4"

# ➤ zoxide (smarter cd that learns your habits)
eval "$(zoxide init zsh)"

# fzf-tab configuration (must be set before the plugin is loaded)
zstyle ':fzf-tab:*' fzf-command fzf
zstyle ':fzf-tab:*' fzf-flags \
  --color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
  --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
  --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
  --color=selected-bg:#45475A \
  --color=border:#6C7086,label:#CDD6F4

# ➤ Antidote (zsh plugin manager) — plugins listed in ~/.zsh_plugins.txt
source "$HOMEBREW_PREFIX/opt/antidote/share/antidote/antidote.zsh"
antidote load

# ➤ Update all Homebrew packages
alias update-all='brew update && brew upgrade && brew cleanup'

# ➤ lsd (a modern ls with colors and icons)
alias ls='lsd'
alias ll='lsd -lA --group-directories-first'
alias la='lsd -A --group-directories-first'

# ➤ Add LM Studio CLI to PATH
export PATH="$PATH:$HOME/.lmstudio/bin"

export XDG_CONFIG_HOME="$HOME/.config"
export TUCKR_HOME="$HOME"

# ➤ Carapace completions (init script cached on disk to avoid running `carapace` on every startup)
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'

if [[ ! -f ~/.cache/carapace/init.zsh ]]; then
  mkdir -p ~/.cache/carapace
  carapace _carapace zsh > ~/.cache/carapace/init.zsh 2>/dev/null
fi
[[ -f ~/.cache/carapace/init.zsh ]] && source ~/.cache/carapace/init.zsh

# ➤ mise (runtime version manager)
eval "$(mise activate zsh)"

export HOMEBREW_NO_REQUIRE_TAP_TRUST=1
export HOMEBREW_NO_UPGRADE_AUTO_UPDATES_CASKS=1
export EDITOR="zed"

# ➤ Atuin (enhanced shell history)
eval "$(atuin init zsh)"

# ➤ Proton Pass SSH agent socket
export SSH_AUTH_SOCK="$HOME/.ssh/proton-pass-agent.sock"
# pnpm
export PNPM_HOME="/Users/francesco/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end
