#!/usr/bin/env bash
set -euo pipefail

file="${1}"
w="${2:-0}"
h="${3:-0}"
x="${4:-0}"
y="${5:-0}"

CACHE_DIR="/tmp/lf-ueberzug-${PPID}"
FIFO="${CACHE_DIR}/fifo"

start_ueberzug() {
  mkdir -p "$CACHE_DIR"
  if [[ ! -p "$FIFO" ]]; then
    mkfifo "$FIFO"
  fi

  # Start ueberzug daemon once per lf instance (PPID)
  if [[ ! -f "${CACHE_DIR}/pid" ]] || ! kill -0 "$(cat "${CACHE_DIR}/pid")" 2>/dev/null; then
    ueberzug layer --parser bash --silent <"$FIFO" &
    echo $! > "${CACHE_DIR}/pid"
    disown || true
  fi
}

remove_preview() {
  if [[ -p "$FIFO" ]]; then
    printf 'remove [identifier]="preview"\n' > "$FIFO" || true
  fi
}

mime="$(file --mime-type -Lb "$file")"

case "$mime" in
  image/*)
    start_ueberzug
    remove_preview
    printf 'add [identifier]="preview" [x]=%d [y]=%d [width]=%d [height]=%d [path]="%s"\n' \
      "$x" "$y" "$w" "$h" "$file" > "$FIFO"
    ;;
  text/*|application/json)
    remove_preview
    bat --style=plain --color=always --paging=never "$file"
    ;;
  application/pdf)
    remove_preview
    command -v pdftotext >/dev/null 2>&1 && pdftotext "$file" - | head -n 200 || file "$file"
    ;;
  *)
    remove_preview
    file "$file"
    ;;
esac
