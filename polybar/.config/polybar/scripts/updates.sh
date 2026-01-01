#!/bin/bash

# Contar updates disponíveis
updates_arch=$(checkupdates 2>/dev/null | wc -l)
updates_aur=$(yay -Qua 2>/dev/null | wc -l)

total=$((updates_arch + updates_aur))

if [ $total -eq 0 ]; then
  echo "0"
else
  echo "$total"
fi
