# ➤ Environment for every zsh (interactive, scripts, `ssh host command`)
# Keep this file to exports only: it runs before compinit and for non-interactive shells.

# Apple Silicon Homebrew (hard-coded to avoid a slow `brew --prefix` call)
export HOMEBREW_PREFIX="/opt/homebrew"

# `path` is kept unique, so nested shells can't accumulate duplicates
typeset -U path PATH

# Also set by the `environment` launchd agent; kept here for ssh/tmux sessions
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

# tuckr resolves the dotfiles repository as $TUCKR_HOME/dotfiles
export TUCKR_HOME="$HOME"

# `--wait` matters: without it `git commit` / `crontab -e` return before you edit
export EDITOR="zed --wait"
export VISUAL="zed --wait"

# Socket served by the proton-pass launchd agent
export SSH_AUTH_SOCK="$HOME/.ssh/proton-pass-agent.sock"

# Homebrew, then user-local binaries
path=("$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin" $path)
path=("$HOME/.local/bin" $path)

# `mise activate` runs only in interactive shells (see .zshrc), so non-interactive
# shells and scripts fall back to shims
[[ -o interactive ]] || path=("$HOME/.local/share/mise/shims" $path)
