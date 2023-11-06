#!/usr/bin/env bash

#while IFS= read -r i; do
#  echo "$i"
#done < $HOME/.hyprland_rice/themes.txt

key_to_value () {
  while IFS= read -r i; do
    theme_name="$(echo $i | sed 's/ -> /\$/g' | cut -f1 -d '$')"

    if [[ "$1" == "$theme_name" ]]; then
      echo "$(echo $i | sed 's/ -> /\$/g' | cut -f2 -d '$')"

      break
    fi
  done < $HOME/.hyprland_rice/themes.txt
}

chosen_theme="$(cat $HOME/.hyprland_rice/themes.txt | sed 's/ -> /\$/g' | cut -f1 -d "\$" | rofi -dmenu -p "Choose Theme:")"

theme_path=$(key_to_value "$chosen_theme")

notify-send "Theme Chooser" "Setting theme... please wait..."

rm -rf ~/.cache/hyprland_rice/theme > /dev/null 2>&1
cp -r $(readlink -f $theme_path) ~/.cache/hyprland_rice/theme

~/.config/hypr/manage/refresh_theme.sh
~/.config/hypr/scripts/refresh_after_theme_change.sh

notify-send "Theme Chooser" "Set theme! Enjoy! <3"
