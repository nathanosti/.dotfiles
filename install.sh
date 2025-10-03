#!/bin/bash
set -e

DOTFILES="$HOME/.dotfiles"
CONFIGDIR="$DOTFILES/.config"

# --- Pacotes oficiais ---
PACMAN_PKGS="
xorg xorg-xinit xorg-xrandr mesa nvidia-open-dkms nvidia-open-utils
i3-wm i3lock polybar alacritty rofi pcmanfm feh picom dunst flameshot
network-manager-applet playerctl pavucontrol pipewire xsettingsd
libnotify ttf-font-awesome zsh stow git neovim
"

# --- Pacotes AUR (com yay) ---
AUR_PKGS="autotiling chrome-stable ttf-jetbrains-mono-nerd tokyonight-gtk-theme-git oh-my-zsh"

echo "==> Instalando pacotes oficiais..."
sudo pacman -Syu --needed $PACMAN_PKGS

# --- Instala yay (AUR helper) se necessário ---
if ! command -v yay >/dev/null 2>&1; then
  echo "==> yay não encontrado, instalando yay (via git)..."
  cd /tmp
  sudo pacman -S --needed base-devel
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
  cd ..
  rm -rf yay
else
  echo "==> yay já instalado."
fi

echo "==> Instalando pacotes do AUR com yay..."
yay -S --needed $AUR_PKGS

echo "==> Garantindo que ~/.config e ~/.zsh existem..."
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.zsh"

echo "==> Aplicando symlinks para todas as configs em $CONFIGDIR..."
cd "$DOTFILES"

for dir in "$CONFIGDIR"/*; do
  [ -d "$dir" ] || continue
  config_name=$(basename "$dir")
  stow --dir="$DOTFILES" --target="$HOME" ".config/$config_name"
  echo "Symlink aplicado para: $config_name"
done

# Sincroniza .zshrc e .zsh (Oh My Zsh)
if [ -f "$DOTFILES/.zshrc" ]; then
  stow --dir="$DOTFILES" --target="$HOME" ".zshrc"
  echo "Symlink aplicado para .zshrc"
fi
if [ -d "$DOTFILES/.zsh" ]; then
  stow --dir="$DOTFILES" --target="$HOME" ".zsh"
  echo "Symlink aplicado para .zsh"
fi

echo "==> Dotfiles e ambiente aplicados com sucesso!"
