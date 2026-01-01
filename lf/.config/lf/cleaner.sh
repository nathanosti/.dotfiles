#!/usr/bin/env bash
set -euo pipefail

CACHE_DIR="/tmp/lf-ueberzug-${PPID}"
FIFO="${CACHE_DIR}/fifo"

if [[ -p "$FIFO" ]]; then
  printf 'remove [identifier]="preview"\n' > "$FIFO" || true
fi

# Optional: stop daemon when lf exits (safe if already dead)
if [[ -f "${CACHE_DIR}/pid" ]]; then
  pid="$(cat "${CACHE_DIR}/pid")"
  kill "$pid" 2>/dev/null || true
fi

rm -rf "$CACHE_DIR" 2>/dev/null || true
