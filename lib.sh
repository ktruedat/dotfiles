#!/bin/bash

set-wallpaper () {
	killall swaybg
	sleep 0.05
	swaybg -i "$1" -o '*' &
	disown
}
