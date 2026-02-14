#!/bin/bash
set -euo pipefail

if [ -z "${CLAUDE_PROJECT_DIR:-}" ]; then
  exit 0
fi

PROGRESS_FILE="$CLAUDE_PROJECT_DIR/.learning/progress.md"
JOURNAL_FILE="$CLAUDE_PROJECT_DIR/.learning/journal.md"
PLAN_FILE="$CLAUDE_PROJECT_DIR/.learning/plan.md"

# Exit silently if no learning plan exists
if [ ! -f "$PROGRESS_FILE" ]; then
  exit 0
fi

# Build context message
context="[Learning Guide] Active learning plan detected."
context+="\n\n"

# Extract overall progress section
overall=$(sed -n '/^## Overall Progress/,/^---/p' "$PROGRESS_FILE" | head -20)
if [ -n "$overall" ]; then
  context+="$overall"
  context+="\n\n"
fi

# Extract current phase status
current_phase=$(grep -E "^- Current phase:" "$PROGRESS_FILE" | head -1 || true)
if [ -n "$current_phase" ]; then
  context+="$current_phase"
  context+="\n"
fi

# Hint about unlocked phases
if [ -f "$PLAN_FILE" ]; then
  context+="\nUse /lg:progress to see unlocked phases and checkpoint details.\n"
fi

# Last journal entry for continuity (captures Phase, Adjustment, and other ## entries)
if [ -f "$JOURNAL_FILE" ]; then
  last_entry=$(awk '/^## /{found=1; entry=""} found{entry=entry"\n"$0} END{print entry}' "$JOURNAL_FILE" | tail -25)
  if [ -n "$last_entry" ]; then
    context+="\nLast journal entry:"
    context+="$last_entry"
    context+="\n"
  fi
fi

context+="\nRun /lg:next to continue, or /lg:progress for full status."

# Output as systemMessage JSON
if command -v jq &>/dev/null; then
  printf '{"systemMessage": %s}' "$(printf '%s' "$context" | jq -Rs .)"
else
  escaped=$(printf '%s' "$context" | sed 's/\\/\\\\/g; s/"/\\"/g; s/	/\\t/g' | tr '\n' '\\' | sed 's/\\/\\n/g')
  printf '{"systemMessage": "%s"}' "$escaped"
fi
