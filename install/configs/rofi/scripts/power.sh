power_choice=$(echo -e "Lock (SUPER + L)\nShutdown\nReboot\nSuspend" | rofi -dmenu -p "power")
case "$power_choice" in
"Lock (SUPER + L)")
  hyprlock
  ;;
"Log Out (SUPER + M)")
  exit
  ;;
"Shutdown")
  shutdown now
  ;;
"Reboot")
  reboot
  ;;
"Suspend")
  systemctl suspend
  ;;
esac
