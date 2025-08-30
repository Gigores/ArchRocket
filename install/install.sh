USER_HOME=$(eval echo "~$SUDO_USER")
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
countdown="3...2...1"

run_as_user() {
  sudo -u "$SUDO_USER" bash -c "$1"
}

clear
echo " █████╗ ██████╗  █████╗ ██╗  ██╗██████╗  █████╗  █████╗ ██╗  ██╗███████╗████████╗"
echo "██╔══██╗██╔══██╗██╔══██╗██║  ██║██╔══██╗██╔══██╗██╔══██╗██║ ██╔╝██╔════╝╚══██╔══╝"
echo "███████║██████╔╝██║  ╚═╝███████║██████╔╝██║  ██║██║  ╚═╝█████═╝ █████╗     ██║   "
echo "██╔══██║██╔══██╗██║  ██╗██╔══██║██╔══██╗██║  ██║██║  ██╗██╔═██╗ ██╔══╝     ██║   "
echo "██║  ██║██║  ██║╚█████╔╝██║  ██║██║  ██║╚█████╔╝╚█████╔╝██║ ╚██╗███████╗   ██║   "
echo "╚═╝  ╚═╝╚═╝  ╚═╝ ╚════╝ ╚═╝  ╚═╝╚═╝  ╚═╝ ╚════╝  ╚════╝ ╚═╝  ╚═╝╚══════╝   ╚═╝   "
echo
echo -n "the installation will start in "
sleep 1
for ((i = 0; i < ${#countdown}; i++)); do
  echo -n "${countdown:$i:1}"
  sleep 0.33
done
sleep 1
echo
echo "Don't leave! You will need to input password a couple of times."
echo
sleep 3

# installing yay
sudo pacman -S --needed --noconfirm base-devel git
run_as_user 'git clone https://aur.archlinux.org/yay.git /tmp/yay && cd /tmp/yay && makepkg -si --noconfirm && cd ..'

# installing ly
pacman -S --noconfirm ly
systemctl enable ly.service

# installing hyprland
pacman -S --noconfirm pipewire hyprland hyprpaper waybar udiskie
pacman -S --noconfirm xdg-desktop-portal-hyprland wl-clipboard polkit xorg-xwayland xdg-desktop-portal-gtk

# installing apps
pacman -S --noconfirm kitty nemo rofi neovim btop fastfetch pavucontrol networkmanager polkit polkit-gnome mako hyprshot hyprlock hypridle brightnessctl rofi-calc cliphist wget geany geany-plugins
pacman -S --noconfirm fish bat lsd
pacman -S --noconfirm eog lollypop parole engrampa
echo -e "bat cache --build\nclear\nexec fish" >>"$USER_HOME/.bashrc"
systemctl enable NetworkManager.service
run_as_user 'yay -S --noconfirm nmgui-bin'

# installing themes
pacman -S --noconfirm ttf-dejavu ttf-liberation noto-fonts ttf-jetbrains-mono-nerd
pacman -S --noconfirm papirus-icon-theme
mkdir -p "$USER_HOME/.config/bat/"
mkdir -p "$USER_HOME/.config/bat/themes"
wget -P "$USER_HOME/.config/bat/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme
bat cache --buid
run_as_user "yay -S --noconfirm catppuccin-gtk-theme-mocha geany-themes"

# setting up themes
pacman -S --noconfirm dconf
run_as_user "
export DBUS_SESSION_BUS_ADDRESS=\"unix:path=/run/user/$(id -u $SUDO_USER)/bus\"

gsettings set org.gnome.desktop.interface gtk-theme 'catppuccin-mocha-mauve-standard+default'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
gsettings set org.gnome.desktop.interface font-name 'JetBrainsMono Nerd Font Semi-Bold 11'
gsettings set org.gnome.desktop.interface cursor-theme 'default'
gsettings set org.gnome.desktop.interface cursor-size 24
gsettings set org.gnome.desktop.interface toolbar-style 'GTK_TOOLBAR_ICONS'
gsettings set org.gnome.desktop.interface toolbar-icons-size 'GTK_ICON_SIZE_LARGE_TOOLBAR'
gsettings set org.gnome.desktop.interface button-images false
gsettings set org.gnome.desktop.interface menu-images false
gsettings set org.gnome.desktop.interface enable-event-sounds true
gsettings set org.gnome.desktop.interface enable-input-feedback-sounds false
gsettings set org.gnome.settings-daemon.plugins.xsettings hinting 'hintslight'
gsettings set org.gnome.settings-daemon.plugins.xsettings antialiasing 'rgba'
gsettings set org.gnome.desktop.interface gtk-application-prefer-dark-theme true
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
"

# installing configs
rm -rf "$USER_HOME/.config/hypr"
run_as_user "cp -r \"$SCRIPT_DIR/configs/hypr\" \"$USER_HOME/.config/\""
rm -rf "$USER_HOME/.config/gtk-3.0"
run_as_user "cp -r \"$SCRIPT_DIR/configs/gtk-3.0\" \"$USER_HOME/.config/\""
rm -rf "$USER_HOME/.config/gtk-4.0"
run_as_user "cp -r \"$SCRIPT_DIR/configs/gtk-4.0\" \"$USER_HOME/.config/\""
rm "$USER_HOME/.gtkrc-2.0"
run_as_user "cp \"$SCRIPT_DIR/configs/.gtkrc-2.0\" \"$USER_HOME/\""
rm -rf "$USER_HOME/.config/kitty"
run_as_user "cp -r \"$SCRIPT_DIR/configs/kitty\" \"$USER_HOME/.config/\""
rm -rf "$USER_HOME/.config/waybar"
run_as_user "cp -r \"$SCRIPT_DIR/configs/waybar\" \"$USER_HOME/.config/\""
rm -rf "$USER_HOME/.config/mako"
run_as_user "cp -r \"$SCRIPT_DIR/configs/mako\" \"$USER_HOME/.config/\""
rm -rf "$USER_HOME/.config/rofi"
run_as_user "cp -r \"$SCRIPT_DIR/configs/rofi\" \"$USER_HOME/.config/\""
rm -rf "$USER_HOME/.config/fish"
run_as_user "cp -r \"$SCRIPT_DIR/configs/fish\" \"$USER_HOME/.config/\""
rm -rf "$USER_HOME/.config/nvim"
run_as_user "cp -r \"$SCRIPT_DIR/configs/nvim\" \"$USER_HOME/.config/\""
rm -rf "$USER_HOME/.local/share/nemo/actions"
run_as_user "cp -r \"$SCRIPT_DIR/configs/actions\" \"$USER_HOME/.local/share/nemo\""
run_as_user "git clone https://github.com/LazyVim/starter \"$USER_HOME/.config/nvim\""
rm -rf "$USER_HOME/.config/nvim/.git"

# setting up user environment
pacman -S --noconfirm xdg-user-dirs
run_as_user 'xdg-user-dirs-update'
run_as_user "mkdir \"$USER_HOME/Pictures/Screenshots\""

echo ""
echo -e "\033[32mThe installation is complete!\033[0m"
echo -e "You can \033[4mreboot\033[0m now"
