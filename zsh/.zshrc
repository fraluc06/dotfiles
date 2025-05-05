# ========================================
# === Plugin Manager Setup (Zinit) =======
# ========================================
# Verifica se Zinit è già presente, altrimenti lo scarica
if [[ ! -f "${ZDOTDIR:-$HOME}/.zinit/bin/zinit.zsh" ]]; then
  mkdir -p "${ZDOTDIR:-$HOME}/.zinit" && \
  git clone https://github.com/zdharma-continuum/zinit.git "${ZDOTDIR:-$HOME}/.zinit/bin"
fi

# Carica il plugin manager Zinit
source "${ZDOTDIR:-$HOME}/.zinit/bin/zinit.zsh"


# ========================================
# === Plugin Configuration ===============
# ========================================

# ➤ Prompt Starship (installato come programma standalone)
zinit ice from"gh-r" as"program"
zinit light starship/starship
eval "$(starship init zsh)"

# ➤ Suggerimenti dinamici durante la digitazione
zinit light zsh-users/zsh-autosuggestions

# ==============================================
# === Programmi standalone da GitHub Releases ===
# ==============================================

# ➤ fzf (interfacce fuzzy per ricerche e cronologia)
zinit ice from"gh-r" as"program"
zinit light junegunn/fzf
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# ➤ zoxide (navigazione intelligente tra directory)
zinit ice from"gh-r" as"program"
zinit light ajeetdsouza/zoxide
eval "$(zoxide init zsh)"

# ➤ fnm (Node.js version manager)
zinit ice from"gh-r" as"program"
zinit light Schniz/fnm
eval "$(fnm env --use-on-cd)"

# ========================================
# === Plugin Zsh =========================
# ========================================

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


# ================================
# === Filen CLI Setup ===========
# ================================
# Aggiunge il percorso a filen-cli (se esiste)
if [[ -d "$HOME/.filen-cli/bin" ]]; then
  export PATH="$HOME/.filen-cli/bin:$PATH"
fi

# Installa filen-cli solo se il comando non è disponibile
if ! command -v filen >/dev/null 2>&1; then
  echo "📦 Installazione filen-cli..."
  curl -sL https://filen.io/cli.sh | bash
fi


# ========================================
# === Aliases ============================
# ========================================

# ➤ Aggiorna tutti i pacchetti Homebrew
alias update-all='brew update && brew upgrade && brew cleanup'

# ➤ Disinstalla Spyder
alias uninstall-spyder="${HOME}/Library/spyder-6/uninstall-spyder.sh"
