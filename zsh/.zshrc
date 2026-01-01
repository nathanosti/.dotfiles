# ============================================
# POWERLEVEL10K INSTANT PROMPT
# ============================================

typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

# Enable Powerlevel10k instant prompt (deve estar no TOPO)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ============================================
# OH-MY-ZSH CONFIGURATION
# ============================================

# Path to oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Tema Powerlevel10k
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins (removido 'history' para evitar conflito)
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    docker
    docker-compose
    kubectl
    npm
    node
    python
    rust
    sudo
    web-search
    copypath
    copyfile
    command-not-found
    colored-man-pages
    extract
)

source $ZSH/oh-my-zsh.sh

# ============================================
# POWERLEVEL10K CONFIG
# ============================================

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ============================================
# VARIÁVEIS DE AMBIENTE
# ============================================

# Editor padrão
export EDITOR="nano"
export VISUAL="nano"

# History settings
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY

# Cores para man pages (Tokyo Night inspired)
export LESS_TERMCAP_mb=$'\e[1;35m'      # Magenta
export LESS_TERMCAP_md=$'\e[1;36m'      # Cyan
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'     # Yellow
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;32m'      # Green

# Adicione seus paths customizados aqui
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# ============================================
# ALIASES - NAVEGAÇÃO
# ============================================

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~"
alias -- -="cd -"

# ============================================
# ALIASES - COMANDOS MODERNOS
# ============================================

# Bat (cat com syntax highlighting)
if command -v bat &> /dev/null; then
    alias cat="bat --style=auto"
    alias catp="bat --style=plain"
fi

# Exa (ls moderno)
if command -v exa &> /dev/null; then
    alias ls="exa --icons --group-directories-first"
    alias ll="exa -lah --icons --group-directories-first"
    alias la="exa -a --icons --group-directories-first"
    alias lt="exa --tree --level=2 --icons"
    alias tree="exa --tree --icons"
else
    alias ll="ls -lah"
    alias la="ls -A"
fi

# ============================================
# ALIASES - GIT
# ============================================

alias gs="git status"
alias gss="git status -s"
alias ga="git add"
alias gaa="git add ."
alias gc="git commit"
alias gcm="git commit -m"
alias gp="git push"
alias gpl="git pull"
alias gl="git log --oneline --graph --decorate --all"
alias gd="git diff"
alias gco="git checkout"
alias gb="git branch"
alias gba="git branch -a"
alias gf="git fetch"
alias gm="git merge"
alias gr="git remote -v"

# ============================================
# ALIASES - SISTEMA
# ============================================

alias update="sudo pacman -Syu"
alias install="sudo pacman -S"
alias remove="sudo pacman -Rns"
alias search="pacman -Ss"
alias info="pacman -Si"
alias cleanup='sudo pacman -Rns $(pacman -Qtdq) 2>/dev/null || echo "Nada para limpar"'
alias orphans="pacman -Qtdq"

# ============================================
# ALIASES - AUR (YAY)
# ============================================

alias yupdate="yay -Syu"
alias yinstall="yay -S"
alias yremove="yay -Rns"
alias ysearch="yay -Ss"

# ============================================
# ALIASES - DOCKER
# ============================================

alias d="docker"
alias dc="docker-compose"
alias dps="docker ps"
alias dpsa="docker ps -a"
alias dimg="docker images"
alias dstop='docker stop $(docker ps -aq)'
alias drm='docker rm $(docker ps -aq)'
alias dprune="docker system prune -af"
alias dlogs="docker logs -f"

# ============================================
# ALIASES - CONFIGS
# ============================================

alias zshconfig="nano ~/.zshrc"
alias i3config="nano ~/.config/i3/config"
alias alacconfig="nano ~/.config/alacritty/alacritty.toml"
alias picomconfig="nano ~/.config/picom/picom.conf"
alias roficonfig="nano ~/.config/rofi/config.rasi"

# ============================================
# ALIASES - RELOAD
# ============================================

alias reload="source ~/.zshrc && echo '✅ Zsh recarregado!'"
alias i3reload="i3-msg reload && echo '✅ i3 recarregado!'"
alias i3restart="i3-msg restart && echo '✅ i3 reiniciado!'"

# ============================================
# ALIASES - ÚTEIS
# ============================================

alias c="clear"
alias ports="netstat -tulanp"
alias myip="curl -s ifconfig.me && echo"
alias localip="ip -4 addr show | grep -oP '(?<=inet\s)\d+(\.\d+){3}'"
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
alias mkdir="mkdir -pv"
alias wget="wget -c"
alias df="df -h"
alias free="free -h"

# ============================================
# SSH AGENT AUTO-START
# ============================================

# # ============================================
# TREE ALIAS
# ============================================

alias ptree='tree -a -L 3 -I "node_modules|.git|dist|build|.next|.turbo|.cache|.idea|.vscode|coverage|target|vendor|.venv|__pycache__"'

if [ -z "$SSH_AUTH_SOCK" ]; then
   # Check if agent is already running
   if ! pgrep -u "$USER" ssh-agent > /dev/null; then
       eval "$(ssh-agent -s)" > /dev/null
   fi
   
   # Add keys if not already added
   ssh-add -l &>/dev/null
   if [ "$?" != "0" ]; then
       ssh-add ~/.ssh/id_github_pessoal 2>/dev/null
       ssh-add ~/.ssh/id_github_trabalho 2>/dev/null
       ssh-add ~/.ssh/id_azure_trabalho 2>/dev/null
   fi
fi

# ============================================
# NVM (NODE VERSION MANAGER)
# ============================================

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use  # Carrega nvm (lazy load)
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# ============================================
# OUTRAS FERRAMENTAS
# ============================================

# Zoxide (cd inteligente) - se instalado
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi

# ============================================
# FUNÇÕES ÚTEIS
# ============================================

# Criar e entrar em diretório
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Backup rápido de arquivo
backup() {
    if [ -z "$1" ]; then
        echo "Uso: backup <arquivo>"
        return 1
    fi
    cp "$1" "$1.backup-$(date +%Y%m%d-%H%M%S)"
    echo "✅ Backup criado: $1.backup-$(date +%Y%m%d-%H%M%S)"
}

# Buscar em histórico
hist() {
    if [ -z "$1" ]; then
        history
    else
        history | grep "$1"
    fi
}

# Encontrar processo por nome
psgrep() {
    ps aux | grep -v grep | grep -i -e VSZ -e "$1"
}

# Matar processo por nome
killp() {
    if [ -z "$1" ]; then
        echo "Uso: killp <nome_do_processo>"
        return 1
    fi
    pkill -9 "$1"
    echo "✅ Processo '$1' finalizado"
}

# Criar um servidor HTTP simples
serve() {
    local port="${1:-8000}"
    echo "🌐 Servidor rodando em http://localhost:$port"
    python -m http.server "$port"
}

# Git clone e já entra no diretório (RENOMEADO para evitar conflito)
gclone() {
    if [ -z "$1" ]; then
        echo "Uso: gclone <url_do_repositório>"
        return 1
    fi
    git clone "$1" && cd "$(basename "$1" .git)"
}

# Criar branch e fazer checkout (RENOMEADO para evitar conflito)
gnew() {
    if [ -z "$1" ]; then
        echo "Uso: gnew <nome_da_branch>"
        return 1
    fi
    git checkout -b "$1"
}

# Limpar cache do sistema
cleancache() {
    echo "🧹 Limpando cache do pacman..."
    sudo pacman -Scc --noconfirm
    
    if command -v yay &> /dev/null; then
        echo "🧹 Limpando cache do yay..."
        yay -Scc --noconfirm
    fi
    
    echo "🧹 Limpando pacotes órfãos..."
    sudo pacman -Rns $(pacman -Qtdq) 2>/dev/null || echo "Sem pacotes órfãos"
    
    echo "🧹 Limpando cache do usuário..."
    rm -rf ~/.cache/*
    
    echo "✅ Limpeza concluída!"
}

# Update completo do sistema
fullupdate() {
    echo "🔄 Atualizando repositórios oficiais..."
    sudo pacman -Syu
    
    if command -v yay &> /dev/null; then
        echo "🔄 Atualizando AUR..."
        yay -Syu
    fi
    
    if command -v flatpak &> /dev/null; then
        echo "🔄 Atualizando Flatpak..."
        flatpak update -y
    fi
    
    if command -v npm &> /dev/null; then
        echo "🔄 Atualizando pacotes NPM globais..."
        npm update -g
    fi
    
    echo "✅ Sistema completamente atualizado!"
}

# Extrair qualquer arquivo
ex() {
    if [ -f "$1" ] ; then
        case $1 in
            *.tar.bz2)   tar xjf "$1"   ;;
            *.tar.gz)    tar xzf "$1"   ;;
            *.bz2)       bunzip2 "$1"   ;;
            *.rar)       unrar x "$1"   ;;
            *.gz)        gunzip "$1"    ;;
            *.tar)       tar xf "$1"    ;;
            *.tbz2)      tar xjf "$1"   ;;
            *.tgz)       tar xzf "$1"   ;;
            *.zip)       unzip "$1"     ;;
            *.Z)         uncompress "$1";;
            *.7z)        7z x "$1"      ;;
            *.deb)       ar x "$1"      ;;
            *.tar.xz)    tar xf "$1"    ;;
            *.tar.zst)   tar xf "$1"    ;;
            *)           echo "'$1' não pode ser extraído via ex()" ;;
        esac
    else
        echo "'$1' não é um arquivo válido"
    fi
}

# Info rápida do sistema
sysinfo() {
    echo "╔════════════════════════════════════════╗"
    echo "║       INFORMAÇÕES DO SISTEMA           ║"
    echo "╚════════════════════════════════════════╝"
    echo ""
    echo "🖥️  Hostname: $(hostname)"
    echo "👤 Usuário: $(whoami)"
    echo "🐧 Kernel: $(uname -r)"
    echo "💾 Memória: $(free -h | awk '/^Mem:/ {print $3 "/" $2}')"
    echo "💿 Disco: $(df -h / | awk 'NR==2 {print $3 "/" $2 " (" $5 " usado)"}')"
    echo "⏰ Uptime: $(uptime -p | sed 's/up //')"
    echo ""
}

# ============================================
# KEYBINDINGS
# ============================================

# Ctrl+Backspace deleta palavra anterior
bindkey '^H' backward-kill-word

# Ctrl+Delete deleta palavra seguinte
bindkey '^[[3;5~' kill-word

# Ctrl+Seta esquerda/direita para navegar por palavras
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# Home e End
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

# ============================================
# AUTO-COMPLETIONS
# ============================================

# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Colorir completions
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Menu selection com setas
zstyle ':completion:*' menu select

# Autocomplete para aliases
setopt COMPLETE_ALIASES

# ============================================
# OPÇÕES DO ZSH
# ============================================

# Correção automática de comandos
setopt CORRECT
setopt CORRECT_ALL

# Pushd automático ao mudar de diretório
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHDMINUS

# Expansão de glob
setopt EXTENDED_GLOB

# Não faz beep
unsetopt BEEP

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ============================================
# WELCOME MESSAGE (OPCIONAL)
# ============================================

# Descomente o que preferir:
fastfetch
# sysinfo
# echo "🌃 Bem-vindo ao Tokyo Night, $(whoami)!"

# ============================================
# FIM DA CONFIGURAÇÃO
# ============================================

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/nathan/google-cloud-sdk/path.zsh.inc' ]; then . '/home/nathan/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/nathan/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/nathan/google-cloud-sdk/completion.zsh.inc'; fi
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - zsh)"

unsetopt correct_all
