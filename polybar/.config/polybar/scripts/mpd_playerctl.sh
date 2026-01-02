#!/usr/bin/env bash
set -euo pipefail

PLAYER="$(playerctl -l 2>/dev/null | grep '^mpd' | head -n 1 || true)"
if [ -z "${PLAYER}" ]; then
  echo " MPD"
  exit 0
fi

STATUS="$(playerctl --player="$PLAYER" status 2>/dev/null || true)"

case "$STATUS" in
Playing) ICON="" ;;
Paused) ICON="" ;;
Stopped | "") ICON="" ;;
*) ICON="" ;;
esac

META="$(playerctl --player="$PLAYER" metadata --format '{{ artist }} - {{ title }}' 2>/dev/null || true)"
if [ -z "${META}" ]; then
  echo "$ICON MPD"
  exit 0
fi

MAX=60
if [ "${#META}" -gt "$MAX" ]; then
  META="${META:0:$MAX}…"
fi

echo "$ICON $META"
