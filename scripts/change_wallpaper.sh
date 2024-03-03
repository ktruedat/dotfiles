#!/usr/bin/env bash

wallpaper_dir="$HOME/Pictures/Wallpapers" # Change this to your wallpaper directory

# Use find to get the full path of image files and pass them to rofi
selected_wallpaper=$(find "$wallpaper_dir" -type f \( -name '*.jpg' -o -name '*.png' \) -exec basename {} \; | rofi -dmenu -i -p "Choose Wallpaper")

if [[ -n $selected_wallpaper ]]; then
    selected_wallpaper_path=$(find "$wallpaper_dir" -type f -name "$selected_wallpaper")
    swww img "$selected_wallpaper_path"
    notify-send "Wallpaper Changed" "New wallpaper has been set!"
else
    notify-send "Wallpaper Change" "No wallpaper selected. Keeping the current wallpaper."
fi
