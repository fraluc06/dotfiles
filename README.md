## 📁 Dotfiles by [fraluc06]

Configurazioni personali per una shell moderna, produttiva e minimale.
Questa repository contiene i file di configurazione che uso quotidianamente su macOS/Linux, inclusi:

- ⚡ `zsh` con plugin e prompt personalizzato
- 📝 `Neovim` come editor principale
- 🪞 `ghostty` come terminale
- 🛠️ Altri strumenti CLI (SDKMAN, fnm, starship, ecc.)

---
## 📸 Anteprima terminale

![Ghostty Preview](./preview.png)


### 🗂 Struttura

```bash
.config/
├── nvim/                 # Configurazione di Neovim (init.lua o init.vim)
├── ghostty/              # Config di Ghostty terminal
├── starship.toml         # Prompt personalizzato
.zshrc                    # Configurazione Zsh
```

---

### 🚀 Setup rapido

> **Requisiti**: Git, Zsh, Neovim, Homebrew (macOS), o un package manager equivalente.

```bash
# Clona i dotfiles nella home
git clone https://github.com/fraluc06/dotfiles.git ~/.dotfiles

# Entra nella directory
cd ~/.dotfiles

#  Crea i symlink manualmente
ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.config/nvim ~/.config/nvim
ln -s ~/.dotfiles/.config/ghostty ~/.config/ghostty
```

---

### 🧩 Plugin & Tools inclusi

- **Zsh**
  - [`zsh-autosuggestions`](https://github.com/zsh-users/zsh-autosuggestions)
  - [`zsh-syntax-highlighting`](https://github.com/zsh-users/zsh-syntax-highlighting)
  - [`starship`](https://starship.rs)
- **Neovim**
  - LSP, autocompletamento, snippets, ecc. (specifica i plugin se vuoi)
- **Terminale**
  - `ghostty` con tema e font personalizzati

---

### 🔄 Sync & Aggiornamenti

Se usi più macchine, puoi:
- Forkare questa repo e mantenerla privata
- Scrivere uno script di sync/backup
- Usare `chezmoi`, `yadm` o `stow` per una gestione avanzata

---

### 📜 Licenza

MIT – sentiti libero di copiarla, modificarla, migliorare!

---
