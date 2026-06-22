#!/bin/sh
# Auto-bootstrap Proton Pass SSH agent into launchd after symlinking the plist
# Runs on: tuckr set proton-pass

PLIST="$HOME/Library/LaunchAgents/com.proton.pass-cli.ssh-agent.plist"
LABEL="com.proton.pass-cli.ssh-agent"
DOMAIN="gui/$(id -u)"

if [ ! -f "$PLIST" ]; then
  echo "[proton-pass] Plist not found at $PLIST, skipping launchd bootstrap"
  exit 0
fi

if launchctl print "$DOMAIN/$LABEL" >/dev/null 2>&1; then
  # Already loaded: do nothing to avoid interrupting the running agent.
  # To apply plist changes, run manually:
  #   launchctl bootout "$DOMAIN/$LABEL" && launchctl bootstrap "$DOMAIN" "$PLIST"
  echo "[proton-pass] Agent already loaded, nothing to do"
else
  # Bootstrap (load for the first time)
  launchctl bootstrap "$DOMAIN" "$PLIST" 2>/dev/null
  echo "[proton-pass] Agent bootstrapped into launchd"
fi
