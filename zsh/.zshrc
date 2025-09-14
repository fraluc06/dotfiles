# ========================================
# === Plugin Manager Setup (Zinit) =======
# ========================================

# ➤ Verifica se Zinit è già presente, altrimenti lo installa con Homebrew
if [[ ! -f "/opt/homebrew/opt/zinit/zinit.zsh" ]]; then
  brew install zinit
fi

# ➤ Carica il plugin manager Zinit
export HOMEBREW_PREFIX="$(brew --prefix)"
source "$HOMEBREW_PREFIX/opt/zinit/zinit.zsh"

# ========================================
# === Environment Configuration ==========
# ========================================

# ➤ Prompt Starship
eval "$(starship init zsh)"

# ➤ fzf (interfacce fuzzy per ricerche e cronologia)
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# ➤ zoxide (navigazione intelligente tra directory)
eval "$(zoxide init zsh)"

# ========================================
# === Plugin Zsh =========================
# ========================================

# ➤ Suggerimenti dinamici durante la digitazione
zinit light zsh-users/zsh-autosuggestions

# ➤ Interfacce Git interattive con fzf
zinit light wfxr/forgit

# ➤ Completamento automatico con supporto fzf
zinit light Aloxaf/fzf-tab

# ➤ Evidenziazione sintattica (caricare per ultimo)
zinit light zdharma-continuum/fast-syntax-highlighting

# ========================================
# === SDKMAN! Setup ======================
# ========================================

# ➤ Installa SDKMAN! se non esiste
if [[ ! -d "$HOME/.sdkman" ]]; then
  echo "📦 Installazione SDKMAN..."
  curl -s "https://get.sdkman.io" | bash
fi

# ➤ Inizializza SDKMAN!
export SDKMAN_DIR="${HOME}/.sdkman"
[[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]] && source "${SDKMAN_DIR}/bin/sdkman-init.sh"

# ➤ Imposta JAVA_HOME in modo sicuro
if command -v sdk >/dev/null 2>&1; then
  export JAVA_HOME="${SDKMAN_DIR}/candidates/java/current"
fi

# ========================================
# === Python (anaconda) =====================
# ========================================

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# ========================================
# === Go (goenv) =====================
# ========================================

# ➤ Go installato con goenv
eval "$(goenv init -)"

# ========================================
# === Aliases ============================
# ========================================

# ➤ Aggiorna tutti i pacchetti Homebrew
alias update-all='brew update && brew upgrade && brew cleanup'

# ➤ eza (un'alternativa a ls con colori e icone)
alias ls='eza'

# ========================================
# === LM Studio CLI ======================
# ========================================

# ➤ Aggiunge LM Studio CLI al PATH
export PATH="$PATH:/Users/francesco/.lmstudio/bin"

# ========================================
# === Stow Global Ignore =================
# ========================================
# Controlla se ~/.stow-global-ignore esiste, altrimenti lo crea con \.DS_Store
if [[ ! -f "$HOME/.stow-global-ignore" ]]; then
    echo '\\.DS_Store' > "$HOME/.stow-global-ignore"
fi
