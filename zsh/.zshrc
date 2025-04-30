# ================================
# === Plugin Manager Setup =======
# ================================
# Verifica se Zinit è già presente, altrimenti lo scarica
if [[ ! -f "${ZDOTDIR:-$HOME}/.zinit/bin/zinit.zsh" ]]; then
  mkdir -p "${ZDOTDIR:-$HOME}/.zinit" && \
  git clone https://github.com/zdharma-continuum/zinit.git "${ZDOTDIR:-$HOME}/.zinit/bin"
fi

# Carica il plugin manager Zinit
source "${ZDOTDIR:-$HOME}/.zinit/bin/zinit.zsh"


# ================================
# === Plugin Configuration =======
# ================================
# Zsh Autosuggestions: Suggerimenti dinamici durante la digitazione
zinit light zsh-users/zsh-autosuggestions

# Plugin che aggiunge interfacce interattive per i comandi Git (add, log, diff, etc.) usando fzf
zinit load wfxr/forgit

# Plugin per navigare rapidamente tra directory visitate spesso, basato su frequenza e "frecency"
zinit ice from"gh-r" as"program"
zinit load ajeetdsouza/zoxide

eval "$(zoxide init zsh)"

# Plugin che sostituisce il completamento standard con un'interfaccia interattiva tramite fzf
zinit light Aloxaf/fzf-tab

# Zsh Syntax Highlighting: Evidenzia la sintassi (deve essere caricato per ultimo)
zinit light zdharma-continuum/fast-syntax-highlighting


# ================================
# === External Tools Setup =======
# ================================
# FZF: Verifica se è installato e carica le configurazioni
if command -v fzf >/dev/null 2>&1; then
  [[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
else
  echo "⚠️ fzf non trovato. Installa con 'brew install fzf' o seguendo la guida su https://github.com/junegunn/fzf"
fi

# Starship: Verifica se è installato e inizializzalo per il prompt personalizzato
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
else
  echo "⚠️ starship non trovato. Installa con 'brew install starship' o seguendo la guida su https://starship.rs"
fi


# ================================
# === Environment Configuration ==
# ================================
# Configura FNM (Fast Node Manager) per gestire le versioni di Node.js
eval "$(fnm env --use-on-cd)"

# Configura SDKMAN! per gestire le versioni di Java
export SDKMAN_DIR="${HOME}/.sdkman"
[[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]] && source "${SDKMAN_DIR}/bin/sdkman-init.sh"
export CURRENT_JAVA_VERSION=$(sdk current java | awk '{print $NF}')
export JAVA_HOME="${SDKMAN_DIR}/candidates/java/current"

# Aggiungi Python al PATH (gestito con uv)
export PATH="$HOME/.local/share/uv/python/cpython-3.13.3-*/bin:$PATH"

# Aggiungi strumenti CLI personalizzati al PATH
export PATH="${PATH}:${HOME}/.filen-cli/bin"

# Aggiungi Rust al PATH (se utilizzi rustup)
export PATH="$HOME/.cargo/bin:$PATH"


# ================================
# === Aliases ====================
# ================================
# Alias per aggiornare tutti i pacchetti con Brew
alias update-all='brew update && brew upgrade && brew cleanup'

# Alias per disinstallare Spyder
alias uninstall-spyder="${HOME}/Library/spyder-6/uninstall-spyder.sh"
