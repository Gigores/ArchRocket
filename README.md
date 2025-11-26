# ArchRocket

![Nemo file manager and LazyVim](Screenshots/1.png)
![Fish shell](Screenshots/2.png)

ArchRocket is a minimalistic, Catppuccin-themed, plug-and-play Arch Linux post-installation script.
Originally created for personal use, now shared on GitHub.

## Features

- Installs essential packages: Hyprland, Ly login manager, Fish, Nemo, and more.
- Sets up user environment: standard directories (`Downloads`, `Pictures`, `Videos`, etc.).
- Configures GTK and icon themes (Catppuccin + Papirus-Dark).
- Applies user-friendly keybindings and Hyprland window rules.
- Adds an ability to take screenshots with text extraction (hyprshot + tesseract)

## Installation

Before running **ArchRocket**, make sure the following conditions are met:

- A fresh Arch Linux installation is used (preferably installed via **archinstall** or similar method).
- An audio server (like **PipeWire** or **PulseAudio**) is already set up.
- Graphics card drivers are set up.

To install, clone the repository and run the script as root:

```bash
git clone https://github.com/Gigores/ArchRocket.git
cd ArchRocket/install
sudo bash install.sh
```
