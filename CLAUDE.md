# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository for macOS, managed using **GNU Stow**. Each application/tool has its own directory, and Stow creates symlinks from these directories to `$HOME`. The `.stowrc` file at the root configures Stow to target `$HOME` by default.

## Key Architecture Principles

### Stow-Based Management
- **Each top-level directory** (e.g., `zsh/`, `ghostty/`, `aerospace/`) is a Stow package
- **Package structure**: Mirrors the target filesystem structure starting from `$HOME`
  - Example: `zsh/.zshrc` → `$HOME/.zshrc`
  - Example: `ghostty/.config/ghostty/config` → `$HOME/.config/ghostty/config`
- **Symlink installation**: `stow <package-name>` creates the appropriate symlinks
- **Bulk installation**: `stow */` installs all packages at once (the `/` ensures only directories are selected)
- **Uninstallation**: `stow -D <package-name>` removes symlinks for a package

### Configuration Structure
The repository contains configurations for:
- **Shell**: Zsh with Zinit plugin manager, Starship prompt, and various plugins
- **Terminal**: Ghostty with Catppuccin Mocha theme and JetBrains Mono Nerd Font
- **Window Manager**: AeroSpace tiling window manager for macOS
- **File Manager**: yazi terminal file manager with custom themes
- **Editor**: Zed editor (Neovim config exists but directory is empty)
- **Package Management**: Homebrew with Brewfile for reproducible installs
- **Tools**: Atuin (shell history), SDKMAN! (Java/JVM), conda (Python)

## Common Commands

### Dotfile Management
```bash
# Install a specific package
stow zsh

# Install all packages
stow */

# Uninstall a package
stow -D ghostty

# Reinstall a package (useful after updates)
stow -R aerospace
```

### Package Management
```bash
# Install all packages from Brewfile
brew bundle --file=~/dotfiles/Brewfile

# Update all Homebrew packages (alias defined in .zshrc)
update-all

# Dump current Homebrew packages to Brewfile
brew bundle dump --file=~/dotfiles/Brewfile --force
```

### Python Environment Setup
```bash
# Create university virtualenv
pyenv virtualenv 3.13 uni-env
pyenv activate uni-env
pip install -r ./requirements.txt
```

### Checking Configuration Status
```bash
# See what Stow would do without making changes
stow -nv zsh

# Check current stow configuration
cat ~/.stowrc
```

## Important Implementation Notes

### When Modifying Configurations
1. **Edit files in the dotfiles repo**, not the symlinked files in `$HOME`
2. **Changes to symlinked files** automatically affect the source (they're the same file)
3. **After adding new config files**, run `stow -R <package>` to update symlinks
4. **Stow ignores**: Configured in `.stowrc` and `~/.stow-global-ignore` (auto-created for `.DS_Store`)

### Zsh Configuration (.zshrc)
- **Plugin manager**: Zinit (installed via Homebrew)
- **Plugin load order matters**: `fast-syntax-highlighting` must load last
- **Key integrations**:
  - Starship prompt (must be initialized early)
  - zoxide for smart directory navigation
  - fzf for fuzzy finding
  - Atuin for advanced shell history
- **SDKMAN!**: Auto-installs if not present, sets `JAVA_HOME` automatically
- **Conda**: Initialization block managed by `conda init`

### Brewfile Structure
- **Taps**: Custom tap for `ffmpeg-svt-av1-essential`
- **Includes**: CLI tools, GUI apps (casks), Mac App Store apps (mas), VSCode extensions
- **VSCode extensions**: Automatically installed via `brew bundle`

### AeroSpace Window Manager
- **Custom workspaces**: Named workspaces (B=browser, T=terminal, etc.) in addition to numbered ones
- **Keybindings**:
  - `alt+<key>` for workspace switching
  - `cmd-ctrl-alt-shift+<key>` for moving windows
  - `cmd-ctrl-alt-shift-r` for resize mode
  - `cmd-ctrl-alt-shift-semicolon` for service mode
- **Gaps**: 18px uniform gaps configured

### Ghostty Terminal
- **Theme**: Catppuccin Mocha (loaded from `themes/` subdirectory)
- **Font**: JetBrains Mono Nerd Font at 16pt
- **Key features**: Copy-on-select enabled, clipboard protection, client-side window decorations

### Git Workflow
- **Staged files** visible in git status: `aerospace.toml`, `yazi/theme.toml`
- **Modified unstaged**: `ghostty/.config/ghostty/config`
- **Untracked**: Various backup files, flavor directories, and markdown docs
- **Main branch**: `main` (use for PRs)

## Development Workflow

When adding a new tool configuration:
1. Create a new directory with the tool name (e.g., `mytool/`)
2. Mirror the expected filesystem structure inside it (e.g., `mytool/.config/mytool/config`)
3. Add the tool to Brewfile if it's a Homebrew package
4. Run `stow mytool` to create symlinks
5. Test the configuration
6. Commit changes to the repository

When removing a tool:
1. Run `stow -D toolname` to remove symlinks
2. Remove the directory from the repository
3. Remove the tool from Brewfile if present
