#!/bin/bash

# Contar containers Docker rodando
if command -v docker &>/dev/null; then
  running=$(docker ps -q 2>/dev/null | wc -l)
  total=$(docker ps -aq 2>/dev/null | wc -l)

  if [ $total -eq 0 ]; then
    echo "0"
  else
    echo "$running/$total"
  fi
else
  echo ""
fi
