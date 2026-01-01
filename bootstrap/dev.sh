#!/usr/bin/env bash
set -euo pipefail

log() { printf "\n==> %s\n" "$*"; }
need_cmd() { command -v "$1" >/dev/null 2>&1 || {
  echo "ERROR: missing command: $1"
  exit 1
}; }

need_cmd pacman

ensure_yay() {
  if command -v yay >/dev/null 2>&1; then
    return 0
  fi

  log "yay not found. Installing yay (AUR helper) ..."
  sudo pacman -S --needed --noconfirm --asdeps git base-devel

  local tmpdir
  tmpdir="$(mktemp -d)"
  trap 'rm -rf "$tmpdir"' EXIT

  git clone https://aur.archlinux.org/yay.git "$tmpdir/yay"
  (cd "$tmpdir/yay" && makepkg -si --noconfirm)

  need_cmd yay
}

install_with_fallback() {
  local -a pkgs=("$@")
  local -a failed=()

  log "Installing with pacman (fallback to yay if needed)"
  sudo pacman -S --needed --noconfirm "${pkgs[@]}" 2> >(tee /tmp/pacman-install.err >&2) || true

  if grep -q "target not found:" /tmp/pacman-install.err; then
    mapfile -t failed < <(grep -oP 'target not found: \K.+' /tmp/pacman-install.err | sort -u)
  fi

  if ((${#failed[@]} > 0)); then
    log "Packages not found in pacman repos: ${failed[*]}"
    ensure_yay
    log "Installing missing packages with yay"
    yay -S --needed --noconfirm "${failed[@]}"
  fi

  rm -f /tmp/pacman-install.err
}

log "Installing development toolchain (pacman/yay fallback)"
DEV_PKGS=(
  base-devel git curl wget unzip zip tar
  openssh ca-certificates
  jq ripgrep fd fzf bat eza
  make cmake pkgconf
  docker docker-compose
  go
  python python-pip python-virtualenv
  rustup
  ruby rubygems
  postgresql-libs
  kubectl
  helm
  k9s
  # Optional: keep nodejs/npm in case you want them even with nvm
  nodejs npm
  # nvm may be in community; fallback handles if not
  nvm
)

install_with_fallback "${DEV_PKGS[@]}"

log "Enabling Docker"
sudo systemctl enable --now docker.service || true
sudo usermod -aG docker "$USER" || true

log "Configuring Rust"
if command -v rustup >/dev/null 2>&1; then
  rustup default stable || true
fi

log "Python: installing pipx + poetry"
python -m pip install --user --upgrade pip
python -m pip install --user --upgrade pipx
"$HOME/.local/bin/pipx" ensurepath || true
"$HOME/.local/bin/pipx" install poetry || "$HOME/.local/bin/pipx" upgrade poetry

log "Node: initializing NVM and installing LTS"
export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
mkdir -p "$NVM_DIR"

# Add NVM init to ~/.zshrc if not present (safe append)
if [[ -f "$HOME/.zshrc" ]] && ! grep -q 'init-nvm\.sh' "$HOME/.zshrc"; then
  cat >>"$HOME/.zshrc" <<'ZSHRC_EOF'

# NVM
export NVM_DIR="$HOME/.nvm"
# shellcheck disable=SC1090
[ -s "/usr/share/nvm/init-nvm.sh" ] && . "/usr/share/nvm/init-nvm.sh"
ZSHRC_EOF
fi

# Load nvm for current run (if installed)
if [[ -s "/usr/share/nvm/init-nvm.sh" ]]; then
  # shellcheck disable=SC1090
  . "/usr/share/nvm/init-nvm.sh"
  nvm install --lts
  nvm use --lts
fi

log "Ruby: installing bundler"
sudo gem update --system || true
sudo gem install bundler || true

log "Git: enabling credential caching (optional)"
git config --global credential.helper cache || true

log "Done."
echo "IMPORTANT: Log out/in (or restart shell) to ensure PATH and group changes (docker) take effect."
