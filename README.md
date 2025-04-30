Here's the updated `README.md` with the additional links to **Catppuccin Mocha** theme and **JetBrains Mono Nerd Font**:

---

## 📁 Dotfiles by fraluc06

Personal configurations for a modern, productive, and minimal shell.
This repository contains the configuration files I use daily on macOS/Linux, including:

- ⚡ **Zsh** with custom plugins and prompt, managed by [Zinit](https://github.com/zdharma-continuum/zinit) ([Z shell - Wikipedia](https://en.wikipedia.org/wiki/Z_shell?utm_source=chatgpt.com))
- 📝 **Neovim** as my primary editor  ([Neovim: Home](https://neovim.io/?utm_source=chatgpt.com))
- 🪞 **Ghostty** as terminal emulator
- 🛠️ Other CLI tools (SDKMAN, fnm, Starship, etc.)
- 🍺 **Homebrew** package management via `Brewfile`  ([Homebrew Bundle, brew bundle and Brewfile](https://docs.brew.sh/Brew-Bundle-and-Brewfile?utm_source=chatgpt.com))

---

## 📸 Terminal Preview

![Ghostty Preview](./preview.png)

---

## 🗂 Repository Structure

```bash
.config/
├── nvim/                 # Neovim configuration (init.lua or init.vim)
├── ghostty/              # Ghostty terminal config
├── starship.toml         # Starship prompt configuration
.zshrc                    # Zsh configuration
Brewfile                  # Homebrew package list for Brew Bundle
```

---

## 🚀 Quick Setup

### Prerequisites

Make sure you have installed:
- **Git**
- **Zsh**
- **Neovim**
- **Homebrew** (on macOS) or an equivalent package manager
- **GNU Stow** for dotfile management  ([Stow - GNU Project - Free Software Foundation](https://www.gnu.org/software/stow/?utm_source=chatgpt.com))

### Installation Steps

1. Clone your dotfiles repository into your home directory:

    ```bash
    git clone https://github.com/fraluc06/dotfiles.git ~/.dotfiles
    ```

2. Change into the dotfiles directory:

    ```bash
    cd ~/.dotfiles
    ```

3. Use **GNU Stow** to symlink your configs automatically:

    ```bash
    stow zsh
    stow nvim
    stow ghostty
    ```

4. Install all Homebrew packages and casks from your `Brewfile`:

    ```bash
    brew bundle --file=~/.dotfiles/Brewfile
    ```

---

## 🧩 Included Plugins & Tools

### **Zsh**
- Managed with [Zinit](https://github.com/zdharma-continuum/zinit) for optimal plugin loading
- `zsh-autosuggestions`: Dynamic suggestions while typing
- `zsh-syntax-highlighting`: Syntax highlighting for commands

### **Neovim**
- LSP support, autocompletion, snippets, etc.

### **Terminal**
- **Ghostty** with custom themes and fonts:
  - **[Catppuccin Mocha](https://github.com/catppuccin/zsh)**: A beautiful dark theme for Zsh and terminal environments
  - **[JetBrains Mono Nerd Font](https://www.nerdfonts.com/font-downloads)**: A monospaced font with programming ligatures and Nerd Font glyphs for an enhanced coding experience

### **Homebrew**
- Declarative package management with `Brewfile` (via `brew bundle`)  ([Homebrew Bundle, brew bundle and Brewfile](https://docs.brew.sh/Brew-Bundle-and-Brewfile?utm_source=chatgpt.com))

---

## 🔄 Sync & Updates

If you use multiple machines, you can:
- Fork this repo and keep it private
- Write a sync/backup script
- Use tools like `chezmoi`, `yadm`, or `stow` for advanced dotfile management

---

## 📜 License

MIT – feel free to copy, modify, and improve!

---
