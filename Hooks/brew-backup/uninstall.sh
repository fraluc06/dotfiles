#!/bin/sh
# Uninstall the brew-backup launchd agent.
# Run this before `tuckr rm brew-backup` to cleanly remove the generated plist.

set -e

PLIST="$HOME/Library/LaunchAgents/com.fraluc06.brew-backup.plist"
LABEL="com.fraluc06.brew-backup"
DOMAIN="gui/$(id -u)"

if launchctl print "$DOMAIN/$LABEL" >/dev/null 2>&1; then
  launchctl bootout "$DOMAIN/$LABEL" 2>/dev/null || true
  echo "[brew-backup] Agent unloaded"
else
  echo "[brew-backup] Agent was not loaded"
fi

if [ -f "$PLIST" ]; then
  rm -f "$PLIST"
  echo "[brew-backup] Removed $PLIST"
else
  echo "[brew-backup] Plist not found at $PLIST"
fi
