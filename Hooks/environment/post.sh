#!/bin/sh
# Auto-load environment.plist into launchd after symlinking
# Sets XDG_CONFIG_HOME (and any other env vars) for GUI apps on login
# Runs on: tuckr set environment

PLIST="$HOME/Library/LaunchAgents/environment.plist"
LABEL="my.startup.shell_agnostic.environment"
DOMAIN="gui/$(id -u)"

if [ ! -f "$PLIST" ]; then
  echo "[environment] Plist not found at $PLIST, skipping launchd bootstrap"
  exit 0
fi

if launchctl print "$DOMAIN/$LABEL" >/dev/null 2>&1; then
  # Already loaded: re-run to refresh env vars
  launchctl kickstart -k "$DOMAIN/$LABEL" 2>/dev/null
  echo "[environment] Agent already loaded, restarted via kickstart"
else
  # Bootstrap (load for the first time)
  launchctl bootstrap "$DOMAIN" "$PLIST" 2>/dev/null
  echo "[environment] Agent bootstrapped into launchd"
fi
