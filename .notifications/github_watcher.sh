#!/bin/bash
# GitHub Activity Monitor for RCT Repository
# Watches for stars, forks, issues, PRs

REPO="templetwo/Relational-Coherence-Training-RTC"
CACHE_FILE="/Users/vaquez/Desktop/Relational-Coherence-Training-RTC/.notifications/.github_cache"

# Create cache file if it doesn't exist
if [ ! -f "$CACHE_FILE" ]; then
    echo "0 0 0 0" > "$CACHE_FILE"
fi

# Read previous counts
read -r PREV_STARS PREV_FORKS PREV_ISSUES PREV_PRS < "$CACHE_FILE"

# Get current counts using GitHub CLI
CURRENT_STARS=$(gh repo view $REPO --json stargazerCount -q .stargazerCount 2>/dev/null || echo "0")
CURRENT_FORKS=$(gh repo view $REPO --json forkCount -q .forkCount 2>/dev/null || echo "0")
CURRENT_ISSUES=$(gh issue list --repo $REPO --state open --json number --jq 'length' 2>/dev/null || echo "0")
CURRENT_PRS=$(gh pr list --repo $REPO --state open --json number --jq 'length' 2>/dev/null || echo "0")

# Check for changes and notify
if [ "$CURRENT_STARS" -gt "$PREV_STARS" ]; then
    NEW_STARS=$((CURRENT_STARS - PREV_STARS))
    osascript -e "display notification \"Your RCT repo gained $NEW_STARS new star(s)! Total: $CURRENT_STARS\" with title \"⭐ GitHub Activity\" sound name \"Glass\""
fi

if [ "$CURRENT_FORKS" -gt "$PREV_FORKS" ]; then
    NEW_FORKS=$((CURRENT_FORKS - PREV_FORKS))
    osascript -e "display notification \"Your RCT repo gained $NEW_FORKS new fork(s)! Total: $CURRENT_FORKS\" with title \"🔱 GitHub Activity\" sound name \"Glass\""
fi

if [ "$CURRENT_ISSUES" -gt "$PREV_ISSUES" ]; then
    NEW_ISSUES=$((CURRENT_ISSUES - PREV_ISSUES))
    osascript -e "display notification \"$NEW_ISSUES new issue(s) opened on RCT repo\" with title \"📋 GitHub Activity\" sound name \"Glass\""
fi

if [ "$CURRENT_PRS" -gt "$PREV_PRS" ]; then
    NEW_PRS=$((CURRENT_PRS - PREV_PRS))
    osascript -e "display notification \"$NEW_PRS new PR(s) opened on RCT repo\" with title \"🔄 GitHub Activity\" sound name \"Glass\""
fi

# Update cache
echo "$CURRENT_STARS $CURRENT_FORKS $CURRENT_ISSUES $CURRENT_PRS" > "$CACHE_FILE"
