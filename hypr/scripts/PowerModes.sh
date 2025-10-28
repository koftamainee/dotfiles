#!/bin/bash

# Get the current power mode
current_mode=$(powerprofilesctl get)

# Cycle to the next mode and set icon
case "$current_mode" in
    "performance")
        next_mode="balanced"
        icon=""
        xrandr --output eDP-1 --mode 2560x1600 --rate 120  # Normal refresh rate
        ;;
    "balanced")
        next_mode="power-saver"
        icon=""
        xrandr --output eDP-1 --mode 2560x1600 --rate 60   # Lower refresh rate for power saving
        ;;
    "power-saver")
        next_mode="performance"
        icon=""
        xrandr --output eDP-1 --mode 2560x1600 --rate 120  # Restore normal refresh rate
        ;;
    *)
        next_mode="balanced"
        icon=""
        xrandr --output eDP-1 --mode 2560x1600 --rate 120
        ;;
esac

# Set the new mode and send notification
powerprofilesctl set "$next_mode"
notify-send -r 9999 "Power Mode" "$icon  $next_mode mode activated" -u low
