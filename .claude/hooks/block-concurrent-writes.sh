#!/bin/bash

INPUT=$(cat)
TOOL=$(echo "$INPUT" | jq -r '.tool_name')
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // .tool_input.path // empty')

ACTIVE_WORK="$CLAUDE_PROJECT_DIR/docs/agents/active-work.md"

# Before any Write or Edit, check if the target file is claimed IN PROGRESS
# by any entry in active-work.md. Match on filename only.

if [ "$TOOL" = "Write" ] || [ "$TOOL" = "Edit" ]; then
  if [ -f "$ACTIVE_WORK" ] && [ -n "$FILE_PATH" ]; then
    TARGET=$(basename "$FILE_PATH")
    CONFLICT=$(grep "IN PROGRESS" "$ACTIVE_WORK" | grep -F "$TARGET" | head -1)
    if [ -n "$CONFLICT" ]; then
      echo "BLOCKED: $TARGET is claimed IN PROGRESS by another agent:" >&2
      echo "$CONFLICT" >&2
      echo "Check docs/agents/active-work.md before proceeding." >&2
      exit 2
    fi
  fi
fi

exit 0
