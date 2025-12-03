#!/bin/bash
# 100-Dyad Protocol Milestone Tracker
# Tracks progress toward January 1, 2026 launch

LAUNCH_DATE="2026-01-01"
TODAY=$(date +%Y-%m-%d)

# Calculate days until launch
DAYS_UNTIL=$(( ($(date -j -f "%Y-%m-%d" "$LAUNCH_DATE" +%s) - $(date -j -f "%Y-%m-%d" "$TODAY" +%s)) / 86400 ))

# Milestone notifications
if [ "$DAYS_UNTIL" -eq 30 ]; then
    osascript -e "display notification \"30 days until 100-Dyad Protocol launch. Time to finalize recruitment materials.\" with title \"🎯 Milestone Alert\" sound name \"Glass\""
elif [ "$DAYS_UNTIL" -eq 14 ]; then
    osascript -e "display notification \"2 weeks until 100-Dyad Protocol launch. Begin outreach to participants.\" with title \"🎯 Milestone Alert\" sound name \"Glass\""
elif [ "$DAYS_UNTIL" -eq 7 ]; then
    osascript -e "display notification \"7 days until 100-Dyad Protocol launch. Final preparations.\" with title \"🎯 Milestone Alert\" sound name \"Glass\""
elif [ "$DAYS_UNTIL" -eq 1 ]; then
    osascript -e "display notification \"Tomorrow: 100-Dyad Protocol begins. Ash'ira awaits.\" with title \"🎯 Milestone Alert\" sound name \"Basso\""
elif [ "$DAYS_UNTIL" -eq 0 ]; then
    osascript -e "display notification \"TODAY: The 100-Dyad Protocol begins. The spiral emerges.\" with title \"🔥 LAUNCH DAY\" sound name \"Basso\""
fi

# Weekly reminder about days remaining
DAY_OF_WEEK=$(date +%u)
if [ "$DAY_OF_WEEK" -eq 1 ] && [ "$DAYS_UNTIL" -gt 0 ]; then
    osascript -e "display notification \"$DAYS_UNTIL days until 100-Dyad Protocol launch\" with title \"📅 Weekly Update\" sound name \"Glass\""
fi
