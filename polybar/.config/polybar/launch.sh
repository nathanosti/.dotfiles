#!/bin/bash

# Terminar instâncias do polybar em execução
killall -q polybar

# Aguardar até os processos serem encerrados
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Aguardar um momento para garantir que tudo foi encerrado
sleep 1

# Limpar logs antigos
rm -f /tmp/polybar*.log

# Detectar monitores conectados
if type "xrandr" &>/dev/null; then
  # Pegar lista de monitores ativos
  monitors=$(xrandr --query | grep " connected" | cut -d" " -f1)

  # Contar monitores
  monitor_count=$(echo "$monitors" | wc -l)

  echo "Monitores detectados: $monitor_count"
  echo "$monitors"

  # Lançar polybar em cada monitor
  for m in $monitors; do
    echo "Lançando Polybar no monitor: $m"
    MONITOR=$m polybar --reload main 2>&1 | tee -a /tmp/polybar-$m.log &
    disown

    # Pequeno delay entre lançamentos
    sleep 0.5
  done

else
  echo "xrandr não encontrado, lançando Polybar sem especificar monitor"
  polybar --reload main 2>&1 | tee -a /tmp/polybar.log &
  disown
fi

echo "Polybar launched on $monitor_count monitor(s)!"
