#!/bin/sh
# tuckr posthook for brew-backup
# Runs on: tuckr set brew-backup
# Generates the launchd plist from the template in Configs/ and bootstraps the agent.

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

if [ -z "${RUN_HOUR}" ] || [ -z "${RUN_MINUTE}" ]; then
  echo "[brew-backup] RUN_HOUR and RUN_MINUTE must be set in $CONFIG_FILE" >&2
  exit 1
fi

case "$RUN_HOUR" in
  ''|*[!0-9]*) echo "[brew-backup] RUN_HOUR must be a number between 0 and 23" >&2; exit 1 ;;
esac
case "$RUN_MINUTE" in
  ''|*[!0-9]*) echo "[brew-backup] RUN_MINUTE must be a number between 0 and 59" >&2; exit 1 ;;
esac
if [ "$RUN_HOUR" -lt 0 ] || [ "$RUN_HOUR" -gt 23 ]; then
  echo "[brew-backup] RUN_HOUR must be between 0 and 23" >&2
  exit 1
fi
if [ "$RUN_MINUTE" -lt 0 ] || [ "$RUN_MINUTE" -gt 59 ]; then
  echo "[brew-backup] RUN_MINUTE must be between 0 and 59" >&2
  exit 1
fi

if [ ! -f "$SRC_PLIST" ]; then
  echo "[brew-backup] Source plist not found: $SRC_PLIST" >&2
  exit 1
fi

# Remove the symlink/file created by tuckr and write a customized plist at the destination
rm -f "$DST_PLIST"
sed -e "s#{{HOME}}#$HOME#g" \
    -e "s#{{HOUR}}#$RUN_HOUR#g" \
    -e "s#{{MINUTE}}#$RUN_MINUTE#g" \
    "$SRC_PLIST" > "$DST_PLIST"

echo "[brew-backup] Generated $DST_PLIST (runs daily at $(printf '%02d:%02d' "$RUN_HOUR" "$RUN_MINUTE"))"

# Unload if already loaded, then bootstrap
if launchctl print "$DOMAIN/$LABEL" >/dev/null 2>&1; then
  launchctl bootout "$DOMAIN/$LABEL" 2>/dev/null || true
fi

launchctl bootstrap "$DOMAIN" "$DST_PLIST"
echo "[brew-backup] Agent bootstrapped into launchd"
