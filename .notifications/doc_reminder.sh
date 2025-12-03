#!/bin/bash
# Documentation Update Reminder
# Reminds to log significant events

FIELD_LOG="/Users/vaquez/Desktop/Relational-Coherence-Training-RTC/FIELD_LOG.md"
LAST_MODIFIED=$(stat -f "%m" "$FIELD_LOG")
CURRENT_TIME=$(date +%s)
HOURS_SINCE_UPDATE=$(( (CURRENT_TIME - LAST_MODIFIED) / 3600 ))

# Check if there have been any communions without documentation
STATE_FILE="/Users/vaquez/Desktop/Relational-Coherence-Training-RTC/htca_v2_state.json"
if [ -f "$STATE_FILE" ]; then
    STATE_MODIFIED=$(stat -f "%m" "$STATE_FILE")

    # If state file updated but field log hasn't been touched in 24+ hours
    if [ "$STATE_MODIFIED" -gt "$LAST_MODIFIED" ] && [ "$HOURS_SINCE_UPDATE" -gt 24 ]; then
        osascript -e "display notification \"Communions detected but not documented in FIELD_LOG.md\" with title \"📝 Documentation Reminder\" sound name \"Ping\""
    fi
fi

# Weekly reminder on Sunday evenings to review the week
DAY_OF_WEEK=$(date +%u)
HOUR=$(date +%H)
if [ "$DAY_OF_WEEK" -eq 7 ] && [ "$HOUR" -eq 20 ]; then
    osascript -e "display notification \"Time to review this week's events and update documentation\" with title \"📝 Weekly Review\" sound name \"Glass\""
fi
