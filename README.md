## 📁 ***My Dotfiles***

My daily configuration files for a modern, productive, and minimal shell on macOS (Apple Silicon), built around my **.zshrc**:

- ⚡ **Zsh** with custom plugins, managed by Antidote
- ✨ **Starship** prompt, **Atuin** shell history, **zoxide** and **fzf** for navigation
- 📝 **Neovim** (and Zed) as editors
- 🪞 **Ghostty** as terminal emulator
- 🛠️ Other CLI tools (mise, yazi, btop, etc.)
- 🍺 **Homebrew** package management via `Brewfile` **([Homebrew Bundle, brew bundle and Brewfile](https://docs.brew.sh/Brew-Bundle-and-Brewfile))**

---

## 📸 **Terminal Preview**

![Ghostty Preview](./preview.png)

---

## 🗂 **Repository Structure**

```bash
dotfiles/
├── Configs/   # Dotfiles; each Configs/<name>/ subdirectory is one tuckr group
├── Hooks/     # Setup scripts (auto-run on `tuckr set`): brew-backup, environment, proton-pass
└── Brewfile   # Homebrew packages
```

---

## 🚀 **Quick Setup**

### Prerequisites

Make sure you have installed:
- **Git**
- **Zsh**
- **Homebrew** (on macOS)
- **Tuckr** for dotfiles management

### **Installation Steps**

1. Clone your dotfiles repository into a folder in your home directory (the `brew-backup` hook expects `~/dotfiles`):

    ```bash
    git clone https://github.com/fraluc06/dotfiles.git ~/dotfiles && cd ~/dotfiles
    ```
    or via gh CLI:

    ```bash
    gh repo clone fraluc06/dotfiles ~/dotfiles && cd ~/dotfiles
    ```

2. Use **Tuckr** to symlink your configs automatically:

    ```bash
    tuckr add zsh
    tuckr add nvim
    tuckr add ghostty
    # ...
    ```
    or all with one command (escape the `*` so the shell passes it to tuckr):

    ```bash
    tuckr add \*
    ```

    For the SSH + launchd setup (SSH client config, Proton Pass CLI SSH agent daemon, and `XDG_CONFIG_HOME` for GUI apps), run:

    ```bash
    tuckr set ssh proton-pass environment
    ```

    This symlinks the configs **and** runs the posthooks, which auto-bootstrap the launchd agents (`com.proton.pass-cli.ssh-agent` and `my.startup.shell_agnostic.environment`). No manual `launchctl` commands needed.

    To also keep your `Brewfile` up to date automatically, run `tuckr set brew-backup`. It installs a launchd agent that runs `brew bundle dump` once a day (default 03:00, if the Mac is asleep it runs at wake-up) and commits/pushes changes. Schedule, remote and push behavior are set in `Hooks/brew-backup/config.sh`.

3. Install all Homebrew packages and casks from your `Brewfile`:

    ```bash
    brew bundle
    ```

    To refresh the `Brewfile` manually instead of waiting for the daily backup:

    ```bash
    brew bundle dump --file=./Brewfile --force
    ```

## 🧩 **Included Plugins & Tools**

### **Zsh** (default shell)
- Managed with `Antidote` for optimal plugin loading
- `zsh-autosuggestions`: Dynamic suggestions while typing
- `fzf-tab`: Replace zsh's default completion selection menu with fzf
- `fast-syntax-highlighting`: Syntax highlighting for commands
- `forgit` : A utility tool powered by fzf for using git interactively.

### **Nushell** (optional)
- Nushell configs live in the `nushell` group, but the main shell is Zsh. The `XDG_CONFIG_HOME` launchd setup (`environment` group) is shell-agnostic and is covered in the setup steps above.

### **Terminal**
- **Ghostty** with custom themes and fonts:
  - **[Catppuccin](https://github.com/catppuccin/)**: Ghostty is configured for automatic theme switching (`theme = light:Catppuccin Latte,dark:Catppuccin Mocha`), but macOS is kept in dark mode, so **Catppuccin Mocha** is effectively always active. Wherever a tool supports themes, Catppuccin Mocha is used.
  - **[Maple Mono Normal NF](https://font.subf.dev/en/)**: A rounded monospaced font with Nerd Font glyphs and cursive italics for an enhanced coding experience

---

## 📜 **License**

MIT – Free to use, modify, and distribute with attribution.

---
