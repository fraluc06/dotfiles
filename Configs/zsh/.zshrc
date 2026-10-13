#!/bin/zsh
# ➤ Homebrew on Apple Silicon (hard-coded to avoid a slow `brew --prefix` call)
export HOMEBREW_PREFIX="/opt/homebrew"

# ➤ PATH hygiene: `path` is kept unique, so nested shells can't accumulate duplicates
typeset -U path PATH

# ➤ Faster completion startup: reuse the cached .zcompdump, rebuild it at most once a day
autoload -Uz compinit
setopt EXTENDED_GLOB
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.m-1) ]]; then
  compinit -C
else
  compinit
fi
unsetopt EXTENDED_GLOB

# ➤ Starship prompt (init script cached on disk to avoid running `starship` on every startup)
if (( $+commands[starship] )); then
  _cache="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/starship-init.zsh"
  _cfg="${XDG_CONFIG_HOME:-$HOME/.config}/starship.toml"
  if [[ ! -s "$_cache" || "$_cache" -ot ${commands[starship]} || ( -e "$_cfg" && "$_cache" -ot "$_cfg" ) ]]; then
    mkdir -p "${_cache:h}"
    starship init zsh >| "$_cache"
  fi
  source "$_cache"
  unset _cache _cfg
fi

# ➤ fzf (fuzzy finder for files, searches and history)
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
# fzf — Catppuccin Mocha theme
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#6C7086,label:#CDD6F4"

# ➤ zoxide (smarter cd that learns your habits)
eval "$(zoxide init zsh)"

# fzf-tab configuration (must be set before the plugin is loaded)
zstyle ':fzf-tab:*' fzf-command fzf
zstyle ':fzf-tab:*' fzf-flags \
  --color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
  --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
  --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
  --color=selected-bg:#45475A \
  --color=border:#6C7086,label:#CDD6F4

# ➤ Antidote (zsh plugin manager) — plugins listed in ~/.zsh_plugins.txt
source "$HOMEBREW_PREFIX/opt/antidote/share/antidote/antidote.zsh"
antidote load "$HOME/.zsh_plugins.txt"

# ➤ fast-syntax-highlighting — Catppuccin Mocha theme (~/.config/fsh, tuckr group "fsh")
# fsh is loaded deferred, so chain this task too: zsh-defer runs it right after the plugin.
if [[ -r ${XDG_CONFIG_HOME:-$HOME/.config}/fsh/catppuccin-mocha.ini ]]; then
  if (( ${+functions[zsh-defer]} )); then
    zsh-defer fast-theme -q XDG:catppuccin-mocha
  else
    fast-theme -q XDG:catppuccin-mocha 2>/dev/null
  fi
fi

# ➤ Update all Homebrew packages
alias update-all='brew update && brew upgrade && brew cleanup'

# ➤ lsd (a modern ls with colors and icons)
alias ls='lsd'
alias ll='lsd -lA --group-directories-first'
alias la='lsd -A --group-directories-first'

# ➤ Add LM Studio CLI to PATH
export PATH="$PATH:$HOME/.lmstudio/bin"

export XDG_CONFIG_HOME="$HOME/.config"
export TUCKR_HOME="$HOME"

# ➤ Carapace completions (init script cached on disk to avoid running `carapace` on every startup)
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'

if [[ ! -f ~/.cache/carapace/init.zsh ]]; then
  mkdir -p ~/.cache/carapace
  carapace _carapace zsh > ~/.cache/carapace/init.zsh 2>/dev/null
fi
[[ -f ~/.cache/carapace/init.zsh ]] && source ~/.cache/carapace/init.zsh

# ➤ mise (runtime version manager) — shims instead of `mise activate` (much faster startup)
path=("$HOME/.local/share/mise/shims" $path)

#export HOMEBREW_NO_UPGRADE_AUTO_UPDATES_CASKS=1
export EDITOR="zed"

# ➤ Atuin (enhanced shell history) — init script cached on disk to avoid running `atuin` on every startup
if (( $+commands[atuin] )); then
  _cache="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/atuin-init.zsh"
  _cfg="${XDG_CONFIG_HOME:-$HOME/.config}/atuin/config.toml"
  if [[ ! -s "$_cache" || "$_cache" -ot ${commands[atuin]} || ( -e "$_cfg" && "$_cache" -ot "$_cfg" ) ]]; then
    mkdir -p "${_cache:h}"
    atuin init zsh >| "$_cache"
  fi
  source "$_cache"
  unset _cache _cfg
fi

# ➤ Proton Pass SSH agent socket
export SSH_AUTH_SOCK="$HOME/.ssh/proton-pass-agent.sock"

# >>> elio shell integration >>>
elio() {
    case "${1-}" in
        shell|-*)
            command elio "$@"
            return $?
            ;;
    esac

    local arg tmp cwd status_code
    for arg in "$@"; do
        case "$arg" in
            --chooser-file|--chooser-file=*)
                command elio "$@"
                return $?
                ;;
        esac
    done

    tmp="$(mktemp -t "elio-cwd.XXXXXX")" || return
    command elio --cwd-file "$tmp" "$@"
    status_code=$?

    if [ -s "$tmp" ]; then
        cwd="$(cat -- "$tmp")"
        rm -f -- "$tmp"
        if [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && [ -d "$cwd" ]; then
            cd -- "$cwd" || return $?
        fi
    else
        rm -f -- "$tmp"
    fi

    return "$status_code"
}
# <<< elio shell integration <<<

# Added by Unsloth installer
export PATH="$HOME/.local/bin:$PATH"
