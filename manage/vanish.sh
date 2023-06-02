#!/bin/bash

configs=(
    "Hyprland" "$HOME/.config/hypr"
    "Alacritty" "$HOME/.config/alacritty"
    "Rofi" "$HOME/.config/rofi"
)

for u in $(seq 0 $((${#configs[@]} / 1))); do
    coname=""
    codir=""

    for i in $(seq 0 1); do
        cfgsv=${configs[$(($((u * 2)) + $i))]}

        if [[ $i == 0 ]]; then
			coname="$cfgsv"
        elif [[ $i == 1 ]]; then
            codir="$cfgsv"
        fi
    done

    if [[ $coname != "" ]]; then
        if [[ -f "$codir/.hyprland_rice" ]]; then
            echo "Removing configurations for ${coname}..."
            rm -rf "$codir"
        fi
    fi
done

echo " "
echo "Done!"
