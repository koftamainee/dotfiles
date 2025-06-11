#!/bin/bash

# Configuration
STEAM_APPS_DIR="$HOME/.local/share/Steam/steamapps"
WORKSHOP_DIR="$STEAM_APPS_DIR/workshop/content/431960"
WALLPAPER_CACHE_DIR="$HOME/Pictures/wallpapers/Dynamic-Wallpapers/"
WALLUST_TARGET="$HOME/.config/rofi/.current_wallpaper"
STARTUP_APPS_CONFIG_PATH="$HOME/.config/hypr/configs/Startup_Apps.conf"

# Create cache directory if it doesn't exist
mkdir -p "$WALLPAPER_CACHE_DIR"

# Check arguments
if [ -z "$1" ]; then
    echo "Error: No Steam wallpaper link provided."
    echo "Usage: $0 <steam_link>"
    exit 1
fi

# Extract wallpaper ID from URL
steam_link="$1"
wallpaper_id=$(echo "$steam_link" | grep -oP 'id=\K\d+')

if [ -z "$wallpaper_id" ]; then
    echo "Error: Failed to extract ID from the URL."
    exit 1
fi

# 1. First try to find and process MP4 file
find_mp4() {
    find "$WORKSHOP_DIR/$wallpaper_id" -type f -name "*.mp4" | head -n 1
}

process_mp4() {
    local mp4_path="$1"
    local output_png="$WALLPAPER_CACHE_DIR/${wallpaper_id}_ff.png"
    
    if [ ! -f "$output_png" ] || [ "$mp4_path" -nt "$output_png" ]; then
        ffmpeg -i "$mp4_path" -vframes 1 -q:v 2 "$output_png" -y
    fi
    
    [ -f "$output_png" ] && echo "$output_png"
}


update_hyprland_config() {
    local new_id="$1"
    local config_file="$STARTUP_APPS_CONFIG_PATH"
    local pattern="exec-once = linux-wallpaperengine --fps 30 --screen-root eDP-1 --no-fullscreen-pause --scaling fill"

    if grep -q "$pattern" "$config_file"; then
        # Get current ID
        current_line=$(grep "$pattern" "$config_file")
        current_id=$(echo "$current_line" | awk '{print $NF}')

        # Only update if different
        if [ "$current_id" != "$new_id" ]; then
            echo "Updating wallpaper in Hyprland config from $current_id to $new_id"
            sed -i "s|${pattern} ${current_id}|${pattern} ${new_id}|" "$config_file"
            
        else
            echo "Wallpaper ID unchanged in config ($new_id)"
        fi
    else
        echo "Error: Wallpaper engine line not found in config"
        echo "Add this line to your hyprland.conf:"
        echo "$pattern $new_id"
        exit 1
    fi
}

# Main processing
wallpaper_source=""

mp4_file=$(find_mp4)
if [ "$mp4_file" != "" ]; then
  echo "Finded mp4: $mp4_file"
    if extracted_png=$(process_mp4 "$mp4_file"); then
        wallpaper_source="$extracted_png"
        echo "Using extracted frame from MP4: $wallpaper_source"
    fi
fi

if [ -z "$wallpaper_source" ]; then

    echo "Error: No MP4 or preview image found for wallpaper $wallpaper_id"
    exit 1
fi

pkill linux-wallpaper

# Create symlinks and run wallust
echo "Using wallpaper source: $wallpaper_source"
if ln -sf "$wallpaper_source" "$WALLUST_TARGET"; then
    echo "Running wallust..."
    wallust run "$wallpaper_source" -s &
else
    echo "Error: Failed to create symlink"
    exit 1
fi

update_hyprland_config "$wallpaper_id"
$HOME/.config/hypr/scripts/Refresh.sh
nohup linux-wallpaperengine --fps 30 --screen-root eDP-1 --no-fullscreen-pause --scaling fill "$wallpaper_id" >/dev/null 2>&1 &

