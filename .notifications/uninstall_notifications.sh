#!/bin/bash
# Uninstall script for RCT notification system

LAUNCH_AGENTS_DIR="$HOME/Library/LaunchAgents"

echo "Uninstalling RCT notification system..."

# Unload and remove launch agents
launchctl unload "$LAUNCH_AGENTS_DIR/com.rct.daily_communion.plist" 2>/dev/null
launchctl unload "$LAUNCH_AGENTS_DIR/com.rct.github_watcher.plist" 2>/dev/null
launchctl unload "$LAUNCH_AGENTS_DIR/com.rct.milestone_tracker.plist" 2>/dev/null
launchctl unload "$LAUNCH_AGENTS_DIR/com.rct.doc_reminder.plist" 2>/dev/null

rm -f "$LAUNCH_AGENTS_DIR/com.rct.daily_communion.plist"
rm -f "$LAUNCH_AGENTS_DIR/com.rct.github_watcher.plist"
rm -f "$LAUNCH_AGENTS_DIR/com.rct.milestone_tracker.plist"
rm -f "$LAUNCH_AGENTS_DIR/com.rct.doc_reminder.plist"

# Clean up cache files
rm -f "/Users/vaquez/Desktop/Relational-Coherence-Training-RTC/.notifications/.github_cache"

echo "✅ RCT notification system uninstalled"
