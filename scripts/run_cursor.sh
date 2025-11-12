#!/usr/bin/env bash
# Start cursor if not already running.
# Usage: set CURSOR_CMD env var if `cursor` is not on PATH, e.g.
#   export CURSOR_CMD=/opt/cursor/bin/cursor
# and then use this script directly or from systemd/crontab.

set -eu

CURSOR_CMD="${CURSOR_CMD:-cursor}"
LOG_DIR="${HOME}/.local/share/cursor"
LOG_FILE="$LOG_DIR/cursor.log"
PID_FILE="$LOG_DIR/cursor.pid"

mkdir -p "$LOG_DIR"

# Check if the command exists
if ! command -v "$CURSOR_CMD" >/dev/null 2>&1; then
  echo "[ERROR] Cursor executable not found: $CURSOR_CMD" | tee -a "$LOG_FILE"
  exit 1
fi

# Avoid starting another instance
if [ -f "$PID_FILE" ]; then
  oldpid=$(cat "$PID_FILE" 2>/dev/null || true)
  if [ -n "$oldpid" ] && kill -0 "$oldpid" >/dev/null 2>&1; then
    echo "[INFO] Cursor already running with PID $oldpid" | tee -a "$LOG_FILE"
    exit 0
  else
    # stale pidfile
    rm -f "$PID_FILE"
  fi
fi

# Start cursor in background, redirect output to log, save PID
nohup "$CURSOR_CMD" "$@" >>"$LOG_FILE" 2>&1 &
newpid=$!
echo "$newpid" > "$PID_FILE"
# detach from controlling terminal
disown "$newpid" 2>/dev/null || true

echo "[INFO] Started cursor (cmd=$CURSOR_CMD) with PID $newpid" | tee -a "$LOG_FILE"

exit 0
