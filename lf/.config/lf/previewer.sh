#!/usr/bin/env bash
set -euo pipefail

FIFO="${LF_UEBERZUG_FIFO:-}"
[[ -p "$FIFO" ]] || exit 0

file="$1"
w="${2:-0}"
h="${3:-0}"
x="${4:-0}"
y="${5:-0}"

# remove sempre (evita “ghost image”)
printf '{"action":"remove","identifier":"preview"}\n' >"$FIFO" || true

((w > 1 && h > 1)) || exit 0

mime="$(file --mime-type -Lb "$file")"

case "$mime" in
image/*)
  printf '{"action":"add","identifier":"preview","x":%d,"y":%d,"max_width":%d,"max_height":%d,"path":"%s"}\n' \
    "$((x + 1))" "$((y + 1))" "$w" "$h" "$file" >"$FIFO"
  ;;
*)
  # nada pra desenhar; o remove acima já limpou
  ;;
esac

exit 0
