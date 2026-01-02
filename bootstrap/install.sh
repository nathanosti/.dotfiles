#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
STOW_PKGS=(
  alacritty
  dunst
  gtk
  htop
  i3
  lazydocker
  lf
  mime
  mpd
  nvim
  picom
  polybar
  rofi
  systemd
  wallpapers
  xsettingsd
  zsh
)

log() { printf "\n==> %s\n" "$*"; }
need_cmd() { command -v "$1" >/dev/null 2>&1 || {
  echo "ERROR: missing command: $1"
  exit 1
}; }

need_cmd pacman

if [[ ! -d "$DOTFILES_DIR" ]]; then
  echo "ERROR: Dotfiles not found at: $DOTFILES_DIR"
  echo "Clone first: git clone <repo> $DOTFILES_DIR"
  exit 1
fi

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

# Install packages using pacman first; failed ones fall back to yay.
install_with_fallback() {
  local -a pkgs=("$@")
  local -a failed=()

  log "Installing with pacman (fallback to yay if needed)"
  sudo pacman -S --needed --noconfirm "${pkgs[@]}" 2> >(tee /tmp/pacman-install.err >&2) || true

  # Detect missing targets (not found in repos)
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

log "Ensuring base dependencies (git, stow)"
sudo pacman -S --needed --noconfirm git stow

# Core i3 environment packages.
CORE_PKGS=(
  i3-wm i3lock i3status
  xorg-xrandr xorg-xsetroot
  polybar rofi picom dunst
  alacritty neovim
  feh
  network-manager-applet networkmanager
  pavucontrol playerctl
  htop
  lf
  xsettingsd
  ttf-jetbrains-mono-nerd

  # MPD / RMPC stack
  mpd mpc
  yt-dlp mpv

  # MPRIS bridge for MPD (AUR in most setups; will fall back to yay)
  mpd-mpris
)

log "Installing core packages for your i3 environment"
install_with_fallback "${CORE_PKGS[@]}"

log "Applying dotfiles with stow"
cd "$DOTFILES_DIR"

# Remove previous symlinks for these packages (safe if not present)
stow -Dv "${STOW_PKGS[@]}" 2>/dev/null || true

# Apply
stow -v "${STOW_PKGS[@]}"

log "Optional: enable NetworkManager"
if systemctl list-unit-files | grep -q '^NetworkManager\.service'; then
  sudo systemctl enable --now NetworkManager.service || true
fi

log "Create common folders"
mkdir -p \
  "$HOME/Pictures/wallpapers" \
  "$HOME/scripts" \
  "$HOME/.local/state/lf" \
  "$HOME/.cache/lf" \
  "$HOME/.config/mpd/playlists" \
  "$HOME/Music"

log "MPD: ensure runtime/state files (do not version these)"
touch \
  "$HOME/.config/mpd/database" \
  "$HOME/.config/mpd/state" \
  "$HOME/.config/mpd/sticker.sql" \
  "$HOME/.config/mpd/log"

log "Enable user services (mpd, mpd-mpris)"
systemctl --user daemon-reload || true
systemctl --user enable --now mpd.service || true
systemctl --user enable --now mpd-mpris.service || true

log "Done."
echo "Tip: reboot or log out/in for all session components to reload."
