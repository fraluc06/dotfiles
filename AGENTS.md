# AGENTS.md



## Repo layout

- `Configs/<group>/...` — each **direct subdirectory is one tuckr group**. Group name = folder name, **case-sensitive and lowercase** (e.g. `zsh`, `proton-pass`, `environment`). Do not rename `Configs/` itself to lowercase — that casing is intentional and was deliberately normalized.
- `Hooks/<group>/post.sh` — setup scripts run **only by `tuckr set <group>`** (not `tuckr add`). `tuckr unset` runs cleanup. Only `environment` and `proton-pass` have hooks.
- `Secrets/` — encrypted `*.mdb` files produced by `tuckr encrypt` (gitignored). Plain credentials (e.g. `aws/credentials`, nushell `history.txt`, `*.log`) are gitignored, not committed.

## Working on a config

1. Edit the file under `Configs/<group>/...` (never edit the symlinked target in `$HOME`).
2. Re-deploy: `tuckr add <group>` (or `tuckr set <group>` if it has hooks).
3. Check state with `tuckr status` / `tuckr ls hooks`.

`TUCKR_HOME="$HOME"` is exported in `.zshrc`; `tuckr` resolves the dotfiles dir from its registered path — it is **not** implied by the current working directory.

## Hook quirks (do not hand-edit run state)

- `environment/post.sh` and `proton-pass/post.sh` bootstrap launchd agents into `gui/$(id -u)`. They no-op if the agent is already loaded.
- For `proton-pass`, this is intentional: re-bootstrapping would interrupt the running SSH agent. To apply a plist change manually: `launchctl bootout "$DOMAIN/$LABEL" && launchctl bootstrap "$DOMAIN" "$PLIST"`.
- `Hooks/*/post.sh` defaults are symlinks of plists into `~/Library/LaunchAgents/`.

## Zsh plugins use `antidote`, NOT Zinit

`README.md` still says Zinit — that is stale on this point (see commit `092e2c6`). The actual loader is **antidote**, sourced from `$HOMEBREW_PREFIX/opt/antidote/share/antidote/antidote.zsh`. Plugin list lives in `Configs/zsh/.zsh_plugins.txt`; the bundled output is cached at `~/.zsh_plugins.zsh` and regenerated when the txt file changes. The `antidote` command is lazily re-aliased on first interactive use.

## Other conventions/gotchas

- **Keep paths portable**: use `$HOME`, `$HOMEBREW_PREFIX` (`/opt/homebrew`, Apple Silicon), `$XDG_CONFIG_HOME`. Avoid hard-coded absolute usernames. (`HOMEBREW_PREFIX` itself is hard-coded to `/opt/homebrew` in `.zshrc` — a deliberate Apple-Silicon assumption.)
- **Brewfile is `brewfile` (lowercase)**. Generated via `brew bundle dump --file=./brewfile --force`, not hand-edited. README's `~/dotfiles/Brewfile` casing is outdated; README also references an `npm-global-packages.json` that does not exist.
- **Git commits are SSH-signed**: `gpg.format = ssh`, signing wrapper at `~/.ssh/git-ssh-sign-wrapper`, key `~/.ssh/id_ed25519.pub`. Credentials delegated to `gh auth git-credential`.
- **`.zshrc` sets `SSH_AUTH_SOCK="$HOME/.ssh/proton-pass-agent.sock"`** — the agent socket is served by the `proton-pass` launchd daemon above. SSH config (`Configs/ssh/`) and the proton-pass plist are deployed together: `tuckr set ssh proton-pass environment`.
- Two Git remotes: `origin` (GitHub) and `codeberg`. Both pushed manually; no release automation.

## README conventions worth preserving

- Plugin loader is **antidote** (the `Plugins` section refers to it as "Antidote"), NOT Zinit.
- Brewfile is lowercase `brewfile`; regenerate via `brew bundle dump --file=./brewfile --force`, not hand-edited.
- A stale README reference to `Brewfile` (capitalized) may still appear in older commit history or derived guides — trust the lowercase form in the repo root.
