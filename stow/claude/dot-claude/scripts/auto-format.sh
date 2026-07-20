#!/usr/bin/env bash
set -e
file=$(jq -r '.tool_input.file_path // empty')
[[ -z "$file" || ! -f "$file" ]] && exit 0
ext="${file##*.}"

case "$ext" in
  ts|tsx|js|jsx|json)
    [[ -f "$CLAUDE_PROJECT_DIR/.prettierrc" ]] && (cd "$CLAUDE_PROJECT_DIR" && bunx prettier --write "$file" 2>&1 | tail -1 || true)
    ;;
  py)
    command -v ruff &>/dev/null && [[ -f "$CLAUDE_PROJECT_DIR/pyproject.toml" ]] && ruff format "$file" || true
    ;;
esac
exit 0