#!/bin/sh
# tuckr posthook for brew-backup
# Runs on: tuckr set brew-backup
# Generates the launchd plist with StartInterval from config.sh and bootstraps the agent.

set -e

CONFIG_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_FILE="$CONFIG_DIR/config.sh"
DOTFILES_DIR="$(cd "$CONFIG_DIR/../.." && pwd)"
SRC_PLIST="$DOTFILES_DIR/Configs/brew-backup/Library/LaunchAgents/com.fraluc06.brew-backup.plist"
DST_PLIST="$HOME/Library/LaunchAgents/com.fraluc06.brew-backup.plist"
LABEL="com.fraluc06.brew-backup"
DOMAIN="gui/$(id -u)"

if [ ! -f "$CONFIG_FILE" ]; then
  echo "[brew-backup] Configuration not found: $CONFIG_FILE" >&2
  exit 1
fi

. "$CONFIG_FILE"

if [ -z "${INTERVAL_HOURS}" ]; then
  echo "[brew-backup] INTERVAL_HOURS is not set in $CONFIG_FILE" >&2
  exit 1
fi

INTERVAL_SECONDS=$((INTERVAL_HOURS * 3600))

if [ ! -f "$SRC_PLIST" ]; then
  echo "[brew-backup] Source plist not found: $SRC_PLIST" >&2
  exit 1
fi

# Remove the symlink/file created by tuckr and write a customized plist at the destination
rm -f "$DST_PLIST"
sed -e "s#{{HOME}}#$HOME#g" -e "s|<integer>21600</integer>|<integer>${INTERVAL_SECONDS}</integer>|" "$SRC_PLIST" > "$DST_PLIST"

echo "[brew-backup] Generated $DST_PLIST with StartInterval=${INTERVAL_SECONDS}s (${INTERVAL_HOURS}h)"

# Unload if already loaded, then bootstrap
if launchctl print "$DOMAIN/$LABEL" >/dev/null 2>&1; then
  launchctl bootout "$DOMAIN/$LABEL" 2>/dev/null || true
fi

launchctl bootstrap "$DOMAIN" "$DST_PLIST"
echo "[brew-backup] Agent bootstrapped into launchd"
