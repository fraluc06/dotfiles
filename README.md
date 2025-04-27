
---

## 📁 Dotfiles by fraluc06
Configurazioni personali per una shell moderna, produttiva e minimale.
Questa repository contiene i file di configurazione che uso quotidianamente su macOS/Linux, inclusi:

- ⚡ **Zsh** con plugin e prompt personalizzato
- 📝 **Neovim** come editor principale
- 🪞 **Ghostty** come terminale
- 🛠️ Altri strumenti CLI (SDKMAN, fnm, starship, ecc.)
- 🍺 **Homebrew** e gestione pacchetti tramite `Brewfile`

---

## 📸 Anteprima terminale

![Ghostty Preview](./preview.png)

---

## 🗂 Struttura

```bash
.config/
├── nvim/                 # Configurazione di Neovim (init.lua o init.vim)
├── ghostty/              # Config di Ghostty terminal
├── starship.toml         # Prompt personalizzato
.zshrc                    # Configurazione Zsh
Brewfile                  # File per la gestione dei pacchetti con Homebrew
```

---

## 🚀 Setup rapido

### Requisiti
Assicurati di avere installato:
- **Git**
- **Zsh**
- **Neovim**
- **Homebrew** (macOS) o un package manager equivalente
- **GNU Stow** (per la gestione dei dotfiles)

### Passaggi di installazione

1. Clona i dotfiles nella home:

    ```bash
    git clone https://github.com/fraluc06/dotfiles.git ~/.dotfiles
    ```

2. Entra nella directory dei dotfiles:

    ```bash
    cd ~/.dotfiles
    ```

3. Usa **GNU Stow** per creare i symlink automaticamente:

    ```bash
    stow zsh
    stow nvim
    stow ghostty
    ```

4. Installa i pacchetti con Homebrew usando il `Brewfile`:

    ```bash
    brew bundle --file=~/.dotfiles/Brewfile
    ```

---

## 🧩 Plugin & Tools inclusi

### **Zsh**
- [`zsh-autosuggestions`](https://github.com/zsh-users/zsh-autosuggestions)
- [`zsh-syntax-highlighting`](https://github.com/zsh-users/zsh-syntax-highlighting)
- [`starship`](https://starship.rs)

### **Neovim**
- LSP, autocompletamento, snippets, ecc. (specifica i plugin se vuoi)

### **Terminale**
- **Ghostty** con tema e font personalizzati

### **Homebrew**
- Gestione dei pacchetti tramite `Brewfile` (installazione automatica di pacchetti e cask)

---

## 🔄 Sync & Aggiornamenti

Se usi più macchine, puoi:
- Forkare questa repo e mantenerla privata
- Scrivere uno script di sync/backup
- Usare strumenti come `chezmoi`, `yadm` o `stow` per una gestione avanzata dei dotfiles

---

## 📜 Licenza

MIT – sentiti libero di copiarla, modificarla, migliorare!

---
