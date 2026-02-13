
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
dotfiles/
├── configs/                 # Dotfiles go here
│   ├── aerospace/           # Aerospace tiling manager
│   ├── ghostty/             # Ghostty terminal
│   ├── nvim/                # Neovim editor
│   ├── nushell/             # Nushell
│   ├── starship/            # Starship prompt
│   ├── yazi/                # Yazi file manager
│   ├── zellij/              # Zellij multiplexer
│   ├── zsh/                 # Zsh shell
│   └── ...                  # Other tool configs
├── brewfile                 # Homebrew packages
├── hooks/                   # Setup scripts go here
└── secrets/                 # Encrypted files go here
```

---

## 🚀 **Quick Setup**

### Prerequisites

Make sure you have installed:
- **Git**
- **Zsh**
- **Nushell**
- **Homebrew** (on macOS) or an equivalent package manager
- **Tuckr** for dotfiles management

### **Installation Steps**

1. Clone your dotfiles repository into a folder in your home directory:

    ```bash
    git clone https://github.com/fraluc06/dotfiles.git ~/.dotfiles
    ```
    or via SSH:

    ```bash
    git clone git@github.com:fraluc06/dotfiles.git ~/.dotfiles
    ```
   or via gh CLI:

    ```bash
    gh repo clone git@github.com:fraluc06/dotfiles.git ~/.dotfiles
    ```

2. Change into the dotfiles directory:

    ```bash
    cd ~/.dotfiles
    ```

3. Use **Tuckr** to symlink your configs automatically:

    ```bash
    tuckr zsh
    tuckr nvim
    tuckr ghostty
    # ...
    ```
    or all with one command

    ```bash
    tuckr */ # Everything (the '/' ignores the README)
    ```

4. Install all Homebrew packages and casks from your `Brewfile`:

    ```bash
    brew bundle --file=~/dotfiles/Brewfile
    ```

5. Install npm packages from the JSON file (requires `jq`):
    ```bash
    bat npm-global-packages.json | jq -r '.dependencies | keys[]' | xargs npm install -g
    ```

---

## 📦 Exporting Packages

This section explains how to export the package lists for Homebrew and npm.

### Homebrew

To update the `Brewfile` with all currently installed packages, run:

```bash
brew bundle dump --file=./Brewfile --force
```

### NPM

To save a list of globally installed npm packages, run:

```bash
npm ls -g --json > npm-global-packages.json
```

---

## 🧩 **Included Plugins & Tools**

### **Zsh**
- Managed with `Zinit` for optimal plugin loading
- `zsh-autosuggestions`: Dynamic suggestions while typing
- `fzf-tab`: Replace zsh's default completion selection menu with fzf
- `fast-syntax-highlighting`: Syntax highlighting for commands
- `forgit` : A utility tool powered by fzf for using git interactively.

### **Nushell**
- To set Nushell as default shell, run:

```bash
z Library/LaunchAgents &&
`echo '<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd"><plist version="1.0">
<dict>
<key>Label</key><string>my.startup.shell_agnostic.environment</string>
<key>ProgramArguments</key><array><string>sh</string><string>-c</string><string>
  launchctl setenv XDG_CONFIG_HOME ~/.config
</string></array>
<key>RunAtLoad</key><true/>
</dict>
</plist>' > ~/Library/LaunchAgents/environment.plist`
```
Then run:
```bash
chsh -s /opt/homebrew/bin/nu
```
and finally reboot your machine.

### **Terminal**
- **Ghostty** with custom themes and fonts:
  - **[Catppuccin Mocha](https://github.com/catppuccin/)**: Catppuccin is a pastel theme with four warm flavors and 26 eye-candy colors, ideal for coding, designing, and other creative tasks.
  - **[JetBrains Mono Nerd Font](https://www.nerdfonts.com/font-downloads)**: A monospaced font with programming ligatures and Nerd Font glyphs for an enhanced coding experience

---

## 📜 **License**

MIT – Free to use, modify, and distribute with attribution.

---
