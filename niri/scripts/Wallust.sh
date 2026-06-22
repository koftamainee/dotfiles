#!/bin/bash
cache_dir="$HOME/.cache/swww/"
ln_success=false

# Get current focused monitor (niri) - extract name from parentheses
current_monitor=$(niri msg outputs | awk 'NR==1{match($0, /\(([^)]+)\)/, a); print a[1]}')
echo "Current monitor: $current_monitor"

cache_file="${cache_dir}${current_monitor}"
echo "Cache file: $cache_file"

if [ -f "$cache_file" ]; then
    wallpaper_path=$(strings "$cache_file" | grep -v 'Lanczos3' | head -n 1)
    echo "Wallpaper path: $wallpaper_path"
    if [ -n "$wallpaper_path" ]; then
        mkdir -p "$HOME/.config/rofi" "$HOME/.config/niri/wallpaper_effects"
        if ln -sf "$wallpaper_path" "$HOME/.config/rofi/.current_wallpaper"; then
            ln_success=true
        fi
        cp "$wallpaper_path" "$HOME/.config/niri/wallpaper_effects/.wallpaper_current"
    else
        echo "No wallpaper path found in cache."
    fi
else
    echo "Cache file for monitor $current_monitor does not exist."
fi

if [ "$ln_success" = true ]; then
    echo "About to execute wallust"
    wallust run "$wallpaper_path" -s &
fi
