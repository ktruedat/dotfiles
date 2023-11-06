#!/usr/bin/env bash

template_files=(
  "eww.scss : $HOME/.config/hypr/eww/eww.scss : scss"
  "waybar.css : $HOME/.config/hypr/waybar/style.css : css"
  "swaync.css : $HOME/.config/hypr/swaync/style.css : css"
  "alacritty.yml : $HOME/.config/alacritty/alacritty.yml : yml"
  "rofi.rasi : $HOME/.config/rofi/themes/generated.rasi : rasi"
)

get_color () {
  theme_data="$(cat $HOME/.cache/hyprland_rice/theme.txt 2> /dev/null || cat $HOME/.config/hypr/themes/gruvbox_dark.txt 2> /dev/null)"

  echo $theme_data | sed 's/;/\n/g' | grep "\$$1 ->" | sed 's/ -> /:/g' | cut -f2 -d ":"
}

translate_file () {
  echo "Hello, world!"
}

for i in "${template_files[@]}"; do
  template_file=$(echo \"$i\" | sed 's/ : /:/g' | cut -f1 -d ':' | sed 's/"//g')
  generated_file=$(echo \"$i\" | sed 's/ : /:/g' | cut -f2 -d ':' | sed 's/"//g')
  translate_to=$(echo \"$i\" | sed 's/ : /:/g' | cut -f3 -d ':' | sed 's/"//g')

  translate_file $template_file $generated_file $translate_to
  get_color foreground
done
