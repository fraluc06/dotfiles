
---

## 📁 ***My Dotfiles***

Personal configurations for a modern, productive, and minimal shell.
Meant to be used with my **.zshrc** on macOS.
This repository contains the configuration files I use daily on macOS/Linux, including:

- ⚡ **Zsh** with custom plugins and prompt, managed by Zinit
- 📝 **Neovim** as my favourite editor within the terminal
- 🪞 **Ghostty** as terminal emulator
- 🛠️ Other CLI tools (SDKMAN, fnm, Starship, etc.)
- 🍺 **Homebrew** package management via `Brewfile`  **([Homebrew Bundle, brew bundle and Brewfile](https://docs.brew.sh/Brew-Bundle-and-Brewfile))**

---

## 📸 **Terminal Preview**

![Ghostty Preview](./preview.png)

---

## 🗂 **Repository Structure**

```bash
.config/
├── nvim/                 # Neovim config
├── ghostty/              # Ghostty terminal config
├── starship/             # Starship prompt config
├── yazi/                 # yazi terminal file explorer config
├── zsh/                  # Zsh configuration
Brewfile                  # Homebrew package list for Brew Bundle
```

---

## 🚀 **Quick Setup**

### Prerequisites

Make sure you have installed:
- **Git**
- **Zsh**
- **Homebrew** (on macOS) or an equivalent package manager
- **GNU Stow** for dotfile management

### **Installation Steps**

1. Clone your dotfiles repository into a folder in your home directory:

    ```bash
    git clone https://github.com/fraluc06/dotfiles.git ~/.dotfiles
    ```
    or via SSH:

    ```bash
    git clone git@github.com:fraluc06/dotfiles.git ~/.dotfiles
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
    # ...
    ```
    or all with one command

    ```bash
    stow */ # Everything (the '/' ignores the README)
    ```

4. Install all Homebrew packages and casks from your `Brewfile`:

    ```bash
    brew bundle --file=~/dotfiles/Brewfile
    ```

---

## 🐍 **Python Setup for University**

### Install Python with pyenv

Make sure you have `pyenv` and `pyenv-virtualenv` installed (it should be included in the `Brewfile`)
**Tip:** You can check the latest available Python version with:
```bash
pyenv install --list
```
```bash
brew install pyenv
pyenv install 3.13
pyenv global 3.13
```
### Creating the virtual environment for the University
```bash
pyenv virtualenv 3.13 uni-env
pyenv activate uni-env
```
### Installing required packages
```bash
pip install -r ./requirements.txt
```

## 🧩 **Included Plugins & Tools**

### **Zsh**
- Managed with `Zinit` for optimal plugin loading
- `zsh-autosuggestions`: Dynamic suggestions while typing
- `fzf-tab`: Replace zsh's default completion selection menu with fzf
- `fast-syntax-highlighting`: Syntax highlighting for commands
- `forgit` : A utility tool powered by fzf for using git interactively.

### **Terminal**
- **Ghostty** with custom themes and fonts:
  - **[Catppuccin Mocha](https://github.com/catppuccin/)**: Catppuccin is a pastel theme with four warm flavors and 26 eye-candy colors, ideal for coding, designing, and other creative tasks.
  - **[JetBrains Mono Nerd Font](https://www.nerdfonts.com/font-downloads)**: A monospaced font with programming ligatures and Nerd Font glyphs for an enhanced coding experience

---

## 🔄 **Sync & Updates**

If you use multiple machines, you can:
- Fork this repo and keep it private
- Write a sync/backup script

---

## 📜 **License**

MIT – feel free to copy, modify, and improve!

---
