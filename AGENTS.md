# AGENTS.md



## Repo layout

- `Configs/<group>/...` — each **direct subdirectory is one tuckr group**. Group name = folder name, **case-sensitive and lowercase** (e.g. `zsh`, `proton-pass`, `environment`). Do not rename `Configs/` itself to lowercase — that casing is intentional and was deliberately normalized.
- `Hooks/<group>/post.sh` — setup scripts run **only by `tuckr set <group>`** (not `tuckr add`). `tuckr unset` runs cleanup. Three groups have hooks: `environment`, `proton-pass`, and `brew-backup`.
- `Secrets/` — encrypted `*.mdb` files produced by `tuckr encrypt` (gitignored). Plain credentials (e.g. `aws/credentials`, nushell `history.txt`, `*.log`) are gitignored, not committed. Currently empty in this checkout.

## Working on a config

1. Edit the file under `Configs/<group>/...` (never edit the symlinked target in `$HOME`).
2. Re-deploy: `tuckr add <group>` (or `tuckr set <group>` if it has hooks).
3. Check state with `tuckr status` / `tuckr ls hooks`.

`TUCKR_HOME="$HOME"` is exported in `.zshrc`; `tuckr` resolves the dotfiles dir from its registered path — it is **not** implied by the current working directory.

## Hook quirks (do not hand-edit run state)

- `environment/post.sh`, `proton-pass/post.sh`, and `brew-backup/post.sh` all bootstrap launchd agents into `gui/$(id -u)`.
- `environment` re-runs are safe: if the agent is already loaded it restarts it via `launchctl kickstart -k` to refresh env vars. `proton-pass` no-ops when already loaded — re-bootstrapping would interrupt the running SSH agent. To apply a plist change manually: `launchctl bootout "$DOMAIN/$LABEL" && launchctl bootstrap "$DOMAIN" "$PLIST"`.
- `brew-backup/post.sh` is different: it reads `Hooks/brew-backup/config.sh` (`RUN_HOUR`, `RUN_MINUTE`, `BREWFILE_PATH`, `GIT_REMOTE`, `PUSH_ENABLED`), **deletes** the tuckr symlink and writes a customized plist (sed of `{{HOME}}`/`{{HOUR}}`/`{{MINUTE}}` placeholders) to `~/Library/LaunchAgents/com.fraluc06.brew-backup.plist`, then bootstraps it. `environment`/`proton-pass` plists are plain tuckr symlinks. To uninstall brew-backup: `./Hooks/brew-backup/uninstall.sh` then `tuckr rm brew-backup`.

## Zsh plugins use `antidote`, NOT Zinit

The loader is **antidote**, sourced from `$HOMEBREW_PREFIX/opt/antidote/share/antidote/antidote.zsh`. Plugin list lives in `Configs/zsh/.zsh_plugins.txt` (deployed to `~/.zsh_plugins.txt`); the bundled output is cached at `~/.zsh_plugins.zsh` and regenerated when the txt file changes. The `antidote` command is lazily re-aliased on first interactive use.

## Other conventions/gotchas

- **Keep paths portable**: use `$HOME`, `$HOMEBREW_PREFIX` (`/opt/homebrew`, Apple Silicon), `$XDG_CONFIG_HOME`. Avoid hard-coded absolute usernames. (`HOMEBREW_PREFIX` itself is hard-coded to `/opt/homebrew` in `.zshrc` — a deliberate Apple-Silicon assumption.)
- **Brewfile is `Brewfile` (Homebrew default name, capitalized)**. Regenerated via `brew bundle dump --file=./Brewfile --force` (also what the `brew-backup` launchd agent does daily), not hand-edited. It was briefly lowercase `brewfile` before commit `4c969ee` renamed it back.
- **Git commits are SSH-signed**: `gpg.format = ssh`, signing wrapper at `~/.ssh/git-ssh-sign-wrapper`, key `~/.ssh/id_ed25519.pub`. Credentials delegated to `gh auth git-credential`.
- **`.zshrc` sets `SSH_AUTH_SOCK="$HOME/.ssh/proton-pass-agent.sock"`** — the agent socket is served by the `proton-pass` launchd daemon above. SSH config (`Configs/ssh/`) and the proton-pass plist are deployed together: `tuckr set ssh proton-pass environment`.
- Two Git remotes: `origin` (GitHub) and `codeberg`. Both pushed manually; no release automation.

## README conventions worth preserving

- Plugin loader is **antidote**, NOT Zinit. Default shell is **Zsh**; Nushell is optional and must not be documented as the main shell.
- Brewfile is `Brewfile` (capitalized); regenerate via `brew bundle dump --file=./Brewfile --force`, not hand-edited.
- The repo lives at `~/dotfiles` (not `~/.dotfiles`): the `brew-backup` hook hard-codes `$HOME/dotfiles/Brewfile` in `Hooks/brew-backup/config.sh`.
- To uninstall the brew-backup agent (no longer in README): `./Hooks/brew-backup/uninstall.sh && tuckr rm brew-backup`.
