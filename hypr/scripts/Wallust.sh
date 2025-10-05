#!/bin/bash

cache_dir="$HOME/.cache/swww/"

# Get a list of monitor outputs
monitor_outputs=($(ls "$cache_dir"))

# Initialize a flag to determine if the ln command was executed
ln_success=false

# Get current focused monitor
current_monitor=$(hyprctl monitors | awk '/^Monitor/{name=$2} /focused: yes/{print name}')
echo "Current monitor: $current_monitor"

# Construct the full path to the cache file
cache_file="$cache_dir$current_monitor"
echo "Cache file: $cache_file"

# Check if the cache file exists for the current monitor output
if [ -f "$cache_file" ]; then
    # Extract wallpaper path safely
    # Use `strings` to filter printable text from binary cache
    wallpaper_path=$(strings "$cache_file" | grep -v 'Lanczos3' | head -n 1)
    echo "Wallpaper path: $wallpaper_path"

    if [ -n "$wallpaper_path" ]; then
        # Ensure target directories exist
        mkdir -p "$HOME/.config/rofi" "$HOME/.config/hypr/wallpaper_effects"

        # Symlink the wallpaper to the location Rofi can access
        if ln -sf "$wallpaper_path" "$HOME/.config/rofi/.current_wallpaper"; then
            ln_success=true
        fi

        # Copy the wallpaper for effects
        cp -r "$wallpaper_path" "$HOME/.config/hypr/wallpaper_effects/.wallpaper_current"
    else
        echo "No wallpaper path found in cache."
    fi
else
    echo "Cache file for monitor $current_monitor does not exist."
fi

# Execute wallust if symlink was successful
if [ "$ln_success" = true ]; then
    echo "About to execute wallust"
    wallust run "$wallpaper_path" -s &
fi
