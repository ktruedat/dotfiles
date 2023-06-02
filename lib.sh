#!/bin/bash



set_wallpaper () {
	killall swaybg
	sleep 0.05
	swaybg -i "$1" -o '*' &
	disown
}

run_hook () {
	$HOME/.hyprland_rice/autostart_$1
}
