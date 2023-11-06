#!/usr/bin/env bash

mkdir ~/.cache/hyprland_rice > /dev/null 2>&1

template_files=(
  "eww.scss : $HOME/.config/hypr/eww/eww.scss : scss"
  "waybar.css : $HOME/.config/hypr/waybar/style.css : css"
  "swaync.css : $HOME/.config/hypr/swaync/style.css : css"
  "alacritty.yml : $HOME/.config/alacritty/alacritty.yml : yml"
  "rofi.rasi : $HOME/.config/rofi/themes/generated.rasi : rasi"
)

if [[ "$1" == "--preview" ]]; then
  template_files=(
    "rofi.rasi : $HOME/.config/rofi/themes/generated_preview.rasi : rasi"
  )
fi

theme_file () {
  if [[ -f ~/.cache/hyprland_rice/theme.txt ]]; then
    echo "$HOME/.cache/hyprland_rice/theme.txt"
  else
    echo "$HOME/.config/hypr/themes/gruvbox_dark.txt"
  fi
}

get_color () {
  theme_data="$(cat $(theme_file))"

  echo $theme_data | sed 's/;/\n/g' | grep "\$$1 ->" | sed 's/ -> /:/g' | cut -f2 -d ":"
}

translate_file () {
  rm $2 > /dev/null 2>&1

  cat $HOME/.config/hypr/templates/$1 > $2

  color_keys=$(cat $(theme_file) | sed 's/;/\n/g' | sed 's/\$//g' | sed 's/ -> /:/g' | cut -f1 -d ":" | sort | tac)

  s_left=""
  s_right=""

  if [[ "$3" == "scss" ]]; then
    s_left='$'
  elif [[ "$3" == "css" ]]; then
    s_left='@'
  elif [[ "$3" == "yml" ]]; then
    s_left='${'
    s_right='}'
  elif [[ "$3" == "rasi" ]]; then
    s_left='${'
    s_right='}'
  fi

  for i in ${color_keys[@]}; do
    rm ~/.cache/hyprland_rice/temp_store > /dev/null 2>&1

    cat $2 | sed "s/${s_left}${i}${s_right}/$(get_color $i)/g" > ~/.cache/hyprland_rice/temp_store
    rm $2
    cat ~/.cache/hyprland_rice/temp_store > $2

    rm ~/.cache/hyprland_rice/temp_store > /dev/null 2>&1
  done
}

for i in "${template_files[@]}"; do
  template_file=$(echo \"$i\" | sed 's/ : /:/g' | cut -f1 -d ':' | sed 's/"//g')
  generated_file=$(echo \"$i\" | sed 's/ : /:/g' | cut -f2 -d ':' | sed 's/"//g')
  translate_to=$(echo \"$i\" | sed 's/ : /:/g' | cut -f3 -d ':' | sed 's/"//g')

  translate_file $template_file $generated_file $translate_to
done

[[ "$1" == "--preview" ]] || touch ~/.cache/hyprland_rice/theme_refreshed
