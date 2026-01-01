#!/usr/bin/env bash
FIFO="${LF_UEBERZUG_FIFO:-}"
[[ -p "$FIFO" ]] && printf '{"action":"remove","identifier":"preview"}\n' >"$FIFO" || true
