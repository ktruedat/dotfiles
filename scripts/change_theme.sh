#!/usr/bin/env bash

#while IFS= read -r i; do
#  echo "$i"
#done < $HOME/.hyprland_rice/themes.txt

rm ~/.cache/hyprland_rice/theme_list.txt > /dev/null 2>&1
cat $HOME/.config/hypr/themes/themes.txt $HOME/.hyprland_rice/themes.txt > $HOME/.cache/hyprland_rice/theme_list.txt

key_to_value () {
  cat $HOME/.cache/hyprland_rice/theme_list.txt | grep "\$$1 ->" | sed 's/\$//g' | sed 's/ -> /\$/g' | cut -f2 -d "\$" | sed 's/;//g'
}

chosen_theme="$(cat $HOME/.cache/hyprland_rice/theme_list.txt | sed 's/\$//g' | sed 's/ -> /\$/g' | cut -f1 -d "\$" | rofi -dmenu -p "Theme")"

theme_path=$(key_to_value "$chosen_theme")
theme_path=$(eval "echo $theme_path")

notify-send "Theme Chooser" "Setting theme... please wait..."

rm -rf ~/.cache/hyprland_rice/theme > /dev/null 2>&1

cp -r "$theme_path" "$HOME/.cache/hyprland_rice/theme"

~/.config/hypr/manage/refresh_theme.sh
~/.config/hypr/scripts/refresh_after_theme_change.sh

notify-send "Theme Chooser" "Set theme! Enjoy! <3"
