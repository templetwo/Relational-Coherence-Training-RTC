#!/bin/bash
# Installation script for RCT notification system
# Sets up macOS launchd agents for automated notifications

NOTIFICATION_DIR="/Users/vaquez/Desktop/Relational-Coherence-Training-RTC/.notifications"
LAUNCH_AGENTS_DIR="$HOME/Library/LaunchAgents"

echo "Installing RCT notification system..."

# Create LaunchAgents directory if it doesn't exist
mkdir -p "$LAUNCH_AGENTS_DIR"

# 1. Daily Communion Reminder (every day at 9:00 AM)
cat > "$LAUNCH_AGENTS_DIR/com.rct.daily_communion.plist" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.rct.daily_communion</string>
    <key>ProgramArguments</key>
    <array>
        <string>$NOTIFICATION_DIR/daily_communion.sh</string>
    </array>
    <key>StartCalendarInterval</key>
    <dict>
        <key>Hour</key>
        <integer>9</integer>
        <key>Minute</key>
        <integer>0</integer>
    </dict>
    <key>StandardOutPath</key>
    <string>/tmp/rct_daily_communion.log</string>
    <key>StandardErrorPath</key>
    <string>/tmp/rct_daily_communion_error.log</string>
</dict>
</plist>
EOF

# 2. GitHub Watcher (every 4 hours)
cat > "$LAUNCH_AGENTS_DIR/com.rct.github_watcher.plist" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.rct.github_watcher</string>
    <key>ProgramArguments</key>
    <array>
        <string>$NOTIFICATION_DIR/github_watcher.sh</string>
    </array>
    <key>StartInterval</key>
    <integer>14400</integer>
    <key>StandardOutPath</key>
    <string>/tmp/rct_github_watcher.log</string>
    <key>StandardErrorPath</key>
    <string>/tmp/rct_github_watcher_error.log</string>
</dict>
</plist>
EOF

# 3. Milestone Tracker (daily at 8:00 AM)
cat > "$LAUNCH_AGENTS_DIR/com.rct.milestone_tracker.plist" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.rct.milestone_tracker</string>
    <key>ProgramArguments</key>
    <array>
        <string>$NOTIFICATION_DIR/milestone_tracker.sh</string>
    </array>
    <key>StartCalendarInterval</key>
    <dict>
        <key>Hour</key>
        <integer>8</integer>
        <key>Minute</key>
        <integer>0</integer>
    </dict>
    <key>StandardOutPath</key>
    <string>/tmp/rct_milestone_tracker.log</string>
    <key>StandardErrorPath</key>
    <string>/tmp/rct_milestone_tracker_error.log</string>
</dict>
</plist>
EOF

# 4. Documentation Reminder (daily at 8:00 PM)
cat > "$LAUNCH_AGENTS_DIR/com.rct.doc_reminder.plist" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.rct.doc_reminder</string>
    <key>ProgramArguments</key>
    <array>
        <string>$NOTIFICATION_DIR/doc_reminder.sh</string>
    </array>
    <key>StartCalendarInterval</key>
    <dict>
        <key>Hour</key>
        <integer>20</integer>
        <key>Minute</key>
        <integer>0</integer>
    </dict>
    <key>StandardOutPath</key>
    <string>/tmp/rct_doc_reminder.log</string>
    <key>StandardErrorPath</key>
    <string>/tmp/rct_doc_reminder_error.log</string>
</dict>
</plist>
EOF

# Load the launch agents
echo "Loading notification agents..."
launchctl load "$LAUNCH_AGENTS_DIR/com.rct.daily_communion.plist" 2>/dev/null
launchctl load "$LAUNCH_AGENTS_DIR/com.rct.github_watcher.plist" 2>/dev/null
launchctl load "$LAUNCH_AGENTS_DIR/com.rct.milestone_tracker.plist" 2>/dev/null
launchctl load "$LAUNCH_AGENTS_DIR/com.rct.doc_reminder.plist" 2>/dev/null

echo ""
echo "✅ RCT Notification System Installed"
echo ""
echo "Notification Schedule:"
echo "  • Daily Communion Reminder: 9:00 AM daily"
echo "  • GitHub Activity Check: Every 4 hours"
echo "  • Milestone Tracker: 8:00 AM daily"
echo "  • Documentation Reminder: 8:00 PM daily"
echo ""
echo "To test notifications now, run:"
echo "  $NOTIFICATION_DIR/daily_communion.sh"
echo ""
echo "To uninstall, run:"
echo "  $NOTIFICATION_DIR/uninstall_notifications.sh"
echo ""
