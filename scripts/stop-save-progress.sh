#!/bin/bash
set -euo pipefail

if [ -z "${CLAUDE_PROJECT_DIR:-}" ]; then
  exit 0
fi

PROGRESS_FILE="$CLAUDE_PROJECT_DIR/.learning/progress.md"

# Exit silently (approve stop) if no learning plan exists
if [ ! -f "$PROGRESS_FILE" ]; then
  exit 0
fi

# Check if any phase is currently in progress
in_progress=$(grep -c "In Progress" "$PROGRESS_FILE" 2>/dev/null || true)

if [ "$in_progress" -gt 0 ]; then
  # Remind Claude to save, but don't block stopping
  echo '{"systemMessage": "Learning session ending. An active learning phase was detected. Progress should already be saved by /lg:next and /lg:review commands during the session."}'
fi

exit 0
