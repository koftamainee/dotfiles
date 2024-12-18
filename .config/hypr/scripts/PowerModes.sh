#!/bin/bash

# Get the current power mode
current_mode=$(powerprofilesctl get)

# Cycle to the next mode and set icon
case "$current_mode" in
    "balanced")
        next_mode="performance"
        icon=""
        xrandr --output eDP-1 --mode 2560x1600 --rate 120  # Restore normal refresh rate
        ;;
    "performance")
        next_mode="balanced"
        icon=""
        xrandr --output eDP-1 --mode 2560x1600 --rate 120 # Set to 60Hz for power saving
        ;;
    *)
        next_mode="balanced"
        icon=""
        xrandr --output eDP-1 --mode 2560x1600 --rate 120  # Restore normal refresh rate
        ;;
esac

# Set the new mode and send notification
powerprofilesctl set "$next_mode"
notify-send -r 9999 "Power Mode" "$icon  $next_mode mode activated" -u low

