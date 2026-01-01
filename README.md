Personal Arch Linux dotfiles managed with **GNU Stow**, focused on a **minimal i3-based workstation** with a complete **developer environment**.

This repository is designed to be applied on top of a **minimal Arch Linux installation created with `archinstall`**.

---

## 🧱 What's Included

### Window Manager & Desktop

- i3 (Tokyo Night themed)
- Polybar
- Picom
- Rofi
- Dunst
- Alacritty (Tokyo Night)
- GTK 3 theming
- Xsettingsd
- Wallpaper managed via `feh`

### Developer Environment

- Zsh + Powerlevel10k
- Neovim (Lazy-based setup)
- Docker + Docker Compose
- Node.js via **NVM**
- Python + pipx + Poetry
- Go
- Ruby + Bundler
- Kubernetes tooling (kubectl, helm, k9s)
- Git, ripgrep, fzf, fd, bat, eza, jq, etc.

### Package Management

- **pacman first**
- **automatic fallback to yay (AUR)** when a package is not available
- yay is auto-installed if missing

---

## 📦 Repository Structure

```
.dotfiles/
├── alacritty
├── dunst
├── gtk
├── htop
├── i3
├── lazydocker
├── libfm
├── mime
├── nvim
├── pcmanfm
├── picom
├── polybar
├── rofi
├── wallpapers
├── xsettingsd
├── zsh
└── bootstrap
    ├── [install.sh](http://install.sh)
    └── [dev.sh](http://dev.sh)
```

Each directory is a GNU Stow package.

---

## 🚀 Installation (Arch Linux Minimal)

### 1️⃣ Install Arch using archinstall

Use the official installer and choose:

- Minimal profile
- NetworkManager
- A user account (non-root)
- Git (optional, can be installed later)

Reboot and log into your user.

### 2️⃣ Install Git (if not installed)

```bash
sudo pacman -S --needed git
```

### 3️⃣ Clone the dotfiles repository

```bash
git clone https://github.com/YOUR_USERNAME/.dotfiles ~/.dotfiles
cd ~/.dotfiles
```

### 4️⃣ Run the base system + desktop setup

This installs:

- i3 environment
- core desktop applications
- fonts
- applies all dotfiles via stow

```bash
./bootstrap/[install.sh](http://install.sh)
```

### 5️⃣ Run the developer environment setup

This installs:

- Docker
- Node (NVM + LTS)
- Python + Poetry
- Go
- Ruby
- Kubernetes tooling

```bash
./bootstrap/[dev.sh](http://dev.sh)
```

⚠️ **Important:**

After this step, log out and log in again (or reboot) so:

- Docker group permissions apply
- PATH updates (pipx, nvm) take effect

---

## 🖼 Wallpaper Management

Wallpaper is managed by i3 + feh and stored at:

```
~/Pictures/wallpapers/wallpaper.jpg
```

The file is versioned in this repository and applied automatically on startup.

To change the wallpaper:

1. Replace `wallpapers/Pictures/wallpapers/wallpaper.jpg`
2. Commit the change
3. Reload i3 or run:

```bash
feh --bg-scale ~/Pictures/wallpapers/wallpaper.jpg
```

---

## 🔁 Reapplying or Updating Dotfiles

To reapply all symlinks:

```bash
cd ~/.dotfiles
stow -R alacritty dunst gtk htop i3 lazydocker libfm mime nvim pcmanfm picom polybar rofi wallpapers xsettingsd zsh
```

To remove symlinks:

```bash
stow -D alacritty dunst gtk htop i3 lazydocker libfm mime nvim pcmanfm picom polybar rofi wallpapers xsettingsd zsh
```

---

## 🛠 Notes & Recommendations

- This setup assumes Xorg + i3, not Wayland
- AUR packages are installed automatically using yay
- Secrets, tokens and caches are intentionally not tracked
- The repository is safe to run multiple times (idempotent)

---

## 📌 Troubleshooting

- If a package is not found in pacman, it will automatically fall back to yay
- If Docker commands fail, ensure you logged out/in after installation
- If wallpaper does not apply, reload i3:

```bash
Mod+Shift+r
```
