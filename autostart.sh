#!/bin/bash



source ~/.config/hypr/lib.sh



run_hook pre &

set_wallpaper ~/.config/hypr/wallpaper.png

~/.config/hypr/waybar/start
~/.config/hypr/mako/start

nm-applet &
blueman-applet &

lxsession &

brightnessctl --restore

run_hook post &
