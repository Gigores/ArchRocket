choice=$(echo -e "App Launcher (SUPER + SPACE)\nClipboard History (SUPER + V)\nCalculator\nPower (SUPER + P)" | rofi -dmenu -p "start" -no-custom)

case "$choice" in
"App Launcher (SUPER + SPACE)")
  rofi -show drun
  ;;
"Clipboard History (SUPER + V)")
  cliphist list | rofi -dmenu -p "clipboard" | cliphist decode | wl-copy
  ;;
"Calculator")
  rofi -show calc -modi calc -no-show-match -no-sort
  ;;
"Power (SUPER + P)")
  bash ~/.config/rofi/scripts/power.sh
  ;;
esac
