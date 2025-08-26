choice=$(echo -e "App Launcher\nClipboard History (SUPER + V)\nCalculator\nPower" | rofi -dmenu -p "menu")

case "$choice" in
	"App Launcher")
		rofi -show drun
		;;
	"Clipboard History (SUPER + V)")
		cliphist list | rofi -dmenu -p "clipboard" | cliphist decode | wl-copy
		;;
	"Calculator")
		rofi -show calc -modi calc -no-show-match -no-sort
		;;
	"Power")
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
		;;
esac


