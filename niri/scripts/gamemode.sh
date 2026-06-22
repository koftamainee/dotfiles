#!/bin/bash

CURRENT=$(powerprofilesctl get)

if [ "$CURRENT" = "performance" ]; then
    powerprofilesctl set balanced

    systemctl --user start waybar
    swww-daemon &

    notify-send -a "Game Mode" -i "power-profile-balanced-symbolic" "Game Mode OFF" "Switched to balanced profile"
else
    powerprofilesctl set performance

    pkill -f "waybar" || true
    pkill -f "swww" || true

    notify-send -a "Game Mode" -i "power-profile-performance-symbolic" "Game Mode ON" "Switched to performance profile"
fi
