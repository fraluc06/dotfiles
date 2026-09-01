#!/bin/sh
# Configuration for the automated brew bundle dump
# This file is sourced by the tuckr posthook (and can be sourced manually).

# Time of day when the backup runs (24h format).
# If the Mac is asleep at that time, launchd runs it at wake-up.
RUN_HOUR=10
RUN_MINUTE=0

# Path to the Brewfile inside your dotfiles repository
BREWFILE_PATH="$HOME/dotfiles/brewfile"

# Git remote to push to when the Brewfile changes (e.g. origin, codeberg)
GIT_REMOTE="origin"

# Set to "true" to automatically commit and push changes to the Brewfile
PUSH_ENABLED=true
