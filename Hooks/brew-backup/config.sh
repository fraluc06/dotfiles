#!/bin/sh
# Configuration for the automated brew bundle dump
# This file is sourced by both the backup script and the tuckr posthook.

# How often to run brew bundle dump (in hours)
INTERVAL_HOURS=24

# Path to the Brewfile inside your dotfiles repository
BREWFILE_PATH="$HOME/dotfiles/Brewfile"

# Git remote to push to when the Brewfile changes (e.g. origin, codeberg)
GIT_REMOTE="origin"

# Set to "true" to automatically commit and push changes to the Brewfile
PUSH_ENABLED=true
