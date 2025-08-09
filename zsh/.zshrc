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

# ➤ Inizializza SDKMAN!
export SDKMAN_DIR=$(brew --prefix sdkman-cli)/libexec
[[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]] && source "${SDKMAN_DIR}/bin/sdkman-init.sh"

# ➤ Imposta JAVA_HOME in modo sicuro
if command -v sdk >/dev/null 2>&1; then
  export JAVA_HOME="${SDKMAN_DIR}/candidates/java/current"
fi


# ========================================
# === Python (pyenv) =====================
# ========================================

# ➤ Python installato con pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(/opt/homebrew/bin/pyenv init --path)"
eval "$(/opt/homebrew/bin/pyenv init -)"
eval "$(/opt/homebrew/bin/pyenv virtualenv-init -)"


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

# ➤ Disinstalla Spyder
alias uninstall-spyder="${HOME}/Library/spyder-6/uninstall-spyder.sh"
# ➤ eza (un'alternativa a ls con colori e icone)
alias ls='eza'


# ========================================
# === LM Studio CLI ======================
# ========================================

# ➤ Aggiunge LM Studio CLI al PATH
export PATH="$PATH:/Users/francesco/.lmstudio/bin"


# ========================================
# === Windsurf CLI ======================
# ========================================

export PATH="$PATH:$HOME/.codeium/windsurf/bin"
