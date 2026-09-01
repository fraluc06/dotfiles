#!/bin/sh
# Periodic brew bundle dump + optional git commit/push
# Triggered by the com.fraluc06.brew-backup launchd agent.

set -e

CONFIG_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_FILE="$CONFIG_DIR/config.sh"

if [ ! -f "$CONFIG_FILE" ]; then
  echo "Configuration not found: $CONFIG_FILE" >&2
  exit 1
fi

. "$CONFIG_FILE"

LOG_FILE="$HOME/Library/Logs/brew-backup.log"
mkdir -p "$(dirname "$LOG_FILE")"

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

log "Starting brew bundle dump"

if [ ! -f "$BREWFILE_PATH" ]; then
  log "ERROR: Brewfile not found at $BREWFILE_PATH"
  exit 1
fi

# Run brew bundle dump
if ! /opt/homebrew/bin/brew bundle dump --file="$BREWFILE_PATH" --force; then
  log "ERROR: brew bundle dump failed"
  exit 1
fi

log "Brewfile dumped to $BREWFILE_PATH"

# Git operations
cd "$(dirname "$BREWFILE_PATH")" || exit 1

if [ ! -d ".git" ]; then
  log "WARNING: $(pwd) is not a git repository, skipping git operations"
  exit 0
fi

if git diff --quiet -- "$BREWFILE_PATH"; then
  log "No changes in Brewfile"
  exit 0
fi

git add -- "$BREWFILE_PATH"
git commit -m "chore(brew): automatic backup $(date '+%Y-%m-%d %H:%M:%S')" || true

if [ "$PUSH_ENABLED" = "true" ] && [ -n "$GIT_REMOTE" ]; then
  if git remote | grep -qx "$GIT_REMOTE"; then
    if git push "$GIT_REMOTE"; then
      log "Pushed to $GIT_REMOTE"
    else
      log "WARNING: git push to $GIT_REMOTE failed"
    fi
  else
    log "WARNING: remote $GIT_REMOTE not found, skipping push"
  fi
fi

log "Backup completed"
