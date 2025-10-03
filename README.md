# Arch Linux Dotfiles: Tokyo Night Setup & i3 Minimal Environment

Este repositório fornece tudo o necessário para um desktop Arch Linux moderno, funcional e visualmente elegante, usando o gerenciador de janelas **i3** e o tema **Tokyo Night**.  
Inclui scripts para instalação automática de pacotes, configuração do ambiente gráfico, shell personalizado (Oh My Zsh), temas, fontes, utilitários e restauração completa das suas configs customizadas via **symlinks**.

---

## 🧩 O que será instalado

### 📦 Pacotes oficiais via `pacman`

- **Ambiente gráfico:** `xorg`, `xorg-xinit`, `xorg-xrandr`, `mesa`
- **Drivers NVIDIA:** `nvidia-open-dkms`, `nvidia-open-utils` *(adapte conforme sua GPU)*
- **Window manager e barra:** `i3-wm`, `polybar`, `i3lock`
- **Visual / compositor / notificações:** `picom`, `feh`, `dunst`
- **Launcher / terminal / file manager:** `rofi`, `alacritty`, `pcmanfm`
- **Print / sistema:** `flameshot`, `network-manager-applet`, `playerctl`, `pavucontrol`
- **Áudio:** `pipewire`, `libnotify`
- **Fontes:** `ttf-font-awesome`
- **Shell e utilitários:** `zsh`, `git`, `stow`, `neovim`
- **Tema GTK e ajustes:** `xsettingsd`

### 📦 Pacotes do AUR via `yay` (instalado automaticamente)

- **Layout automático para i3:** `autotiling`
- **Navegador:** `chrome-stable`
- **Fonte JetBrains Mono Nerd Font:** `ttf-jetbrains-mono-nerd`
- **Tema GTK Tokyo Night:** `tokyonight-gtk-theme-git`
- **Zsh framework:** `oh-my-zsh`

---

## 🗂️ Estrutura da configuração

- Configurações do sistema: `~/.dotfiles/.config/`
- Shell personalizado: `~/.dotfiles/.zshrc` e `~/.dotfiles/.zsh/`
- Wallpapers e scripts opcionais podem ser adicionados no repositório

---

## ⚙️ Instalação segura e automática

Após instalar o Arch e clonar seu repositório de dotfiles:

```bash
git clone git@github.com:SEU-USUARIO/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
chmod +x install.sh
./install.sh

