#!/usr/bin/env bash

while [[ 1 == 1 ]]; do
  if [[ -f ~/.hyprland_rice/disable_vol_cap ]]; then
    echo "Volume cap disabled."
  else
    cd ~/.config/hypr/eww

    if [[ $(./scripts/get_output_volume) -gt 100 ]]; then
      ./scripts/set_output_volume 100%
    fi

    cd ~
  fi

  cd ~
  sleep 1
done
