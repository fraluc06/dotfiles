#!/bin/zsh
# ➤ Homebrew su Apple Silicon (macOS M4 Pro)
export HOMEBREW_PREFIX="/opt/homebrew"

# ➤ Antidote (verrà inizializzato di seguito)

# ➤ Velocizza il caricamento dei completamenti (compinit con cache)
autoload -Uz compinit
setopt EXTENDED_GLOB
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.m-1) ]]; then
  compinit -C
else
  compinit
fi
unsetopt EXTENDED_GLOB

# ➤ Prompt Starship
eval "$(starship init zsh)"

# ➤ fzf (interfacce fuzzy per ricerche e cronologia)
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
# fzf — Catppuccin Mocha
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#6C7086,label:#CDD6F4"

# ➤ zoxide (navigazione intelligente tra directory)
eval "$(zoxide init zsh)"

# Configurazione fzf-tab (deve essere definita prima di caricare il plugin)
zstyle ':fzf-tab:*' fzf-command fzf
zstyle ':fzf-tab:*' fzf-flags \
  --color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
  --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
  --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
  --color=selected-bg:#45475A \
  --color=border:#6C7086,label:#CDD6F4

# ➤ Caricamento dei plugin con Antidote (approccio statico ultra-veloce)
zsh_plugins_txt="${${(%):-%x}:A:h}/.zsh_plugins.txt"
zsh_plugins_zsh="$HOME/.zsh_plugins.zsh"

if [[ ! -f "$zsh_plugins_zsh" || "$zsh_plugins_txt" -nt "$zsh_plugins_zsh" ]]; then
  source "$HOMEBREW_PREFIX/opt/antidote/share/antidote/antidote.zsh"
  antidote bundle < "$zsh_plugins_txt" > "$zsh_plugins_zsh"
fi

# Carica i plugin compilati
source "$zsh_plugins_zsh"

# ➤ Aggiorna tutti i pacchetti Homebrew
alias update-all='brew update && brew upgrade && brew cleanup'

# ➤ eza (un'alternativa a ls con colori e icone)
alias ls='eza'
alias ll='eza -lA --icons --group-directories-first'
alias la='eza -A --icons --group-directories-first'

# ➤ Aggiunge LM Studio CLI al PATH
export PATH="$PATH:/Users/francesco/.lmstudio/bin"

export XDG_CONFIG_HOME="$HOME/.config"
export TUCKR_HOME="$HOME"

# ➤ Load carapace completions (ottimizzato usando la cache asincrona)
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'

if [[ ! -f ~/.cache/carapace/init.zsh ]]; then
  mkdir -p ~/.cache/carapace
  carapace _carapace zsh > ~/.cache/carapace/init.zsh 2>/dev/null
fi
[[ -f ~/.cache/carapace/init.zsh ]] && source ~/.cache/carapace/init.zsh

# ➤ Load mise-en place configuration
eval "$(mise activate zsh)"

# ➤ Mullvad VPN CLI (per comando 'mullvad')
export PATH="/usr/local/bin:$PATH"
export HOMEBREW_REQUIRE_TAP_TRUST=1
export EDITOR="zed"

# ➤ Inizializza Atuin (cronologia shell avanzata)
eval "$(atuin init zsh)"