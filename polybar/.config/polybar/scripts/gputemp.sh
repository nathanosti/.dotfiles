#!/bin/bash

# Pegar temperatura da GPU NVIDIA
if command -v nvidia-smi &>/dev/null; then
  temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null | head -n1)

  if [ -n "$temp" ]; then
    echo "${temp}°C"
  else
    echo "N/A"
  fi
else
  echo "N/A"
fi
