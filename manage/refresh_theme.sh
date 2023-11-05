#!/usr/bin/env bash

template_files=(
  "eww.scss : $HOME/.config/hypr/eww/eww.scss : scss"
  "waybar.css : $HOME/.config/hypr/waybar/style.css : css"
  "swaync.css : $HOME/.config/hypr/swaync/style.css : css"
  "alacritty.yml : $HOME/.config/alacritty/alacritty.yml : yml"
  "rofi.rasi : $HOME/.config/rofi/themes/generated.rasi : rasi"
)

for i in "${template_files[@]}"; do
  template_file=$(echo "$i" | sed 's/ : /:/g' | cut -f1 -d ":")
  generated_file=$(echo "$i" | sed 's/ : /:/g' | cut -f2 -d ":")
  translate_to=$(echo "$i" | sed 's/ : /:/g' | cut -f3 -d ":")

  echo "TF: $template_file, GF: $generated_file, TT: $translate_to"
done
