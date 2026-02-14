#!/bin/bash
set -euo pipefail

if [ -z "${CLAUDE_PROJECT_DIR:-}" ]; then
  exit 0
fi

PROGRESS_FILE="$CLAUDE_PROJECT_DIR/.learning/progress.md"

# Exit silently if no learning plan exists
if [ ! -f "$PROGRESS_FILE" ]; then
  exit 0
fi

# Build critical context to preserve through compaction
context="[Learning Guide — PRESERVE THROUGH COMPACTION]"
context+="\n\n"

# Extract overall progress
overall=$(sed -n '/^## Overall Progress/,/^---/p' "$PROGRESS_FILE" | head -20)
if [ -n "$overall" ]; then
  context+="$overall"
  context+="\n\n"
fi

# Extract current in-progress phase with its checkpoints
current_section=$(awk '/In Progress/{found=1} found{print} found && /^---$/{exit}' "$PROGRESS_FILE")
if [ -n "$current_section" ]; then
  context+="Current phase checkpoints:"
  context+="\n$current_section"
  context+="\n"
fi

context+="\nFiles: .learning/plan.md, .learning/progress.md, .learning/journal.md"
context+="\nCommands: /lg:next, /lg:progress, /lg:review, /lg:decide, /lg:adjust"

# Check for pending learning checkpoints (asked but not yet answered)
pending_learning=$(grep -c '^\- \[ \]' <<< "$current_section" 2>/dev/null || true)
if [ "$pending_learning" -gt 0 ]; then
  context+="\n\nWARNING: There are $pending_learning unchecked learning checkpoints in the current phase."
  context+="\nIf a knowledge check was in progress, re-present the unanswered questions to the learner and WAIT for their response. Do NOT infer or auto-complete their answers."
fi

# Output as systemMessage JSON
if command -v jq &>/dev/null; then
  printf '{"systemMessage": %s}' "$(printf '%s' "$context" | jq -Rs .)"
else
  escaped=$(printf '%s' "$context" | sed 's/\\/\\\\/g; s/"/\\"/g; s/	/\\t/g' | tr '\n' '\\' | sed 's/\\/\\n/g')
  printf '{"systemMessage": "%s"}' "$escaped"
fi
