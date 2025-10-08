SCRIPTSDIR=$HOME/.config/hypr/scripts
UserScripts=$HOME/.config/hypr/UserScripts

# Define file_exists function
file_exists() {
    if [ -e "$1" ]; then
        return 0  # File exists
    else
        return 1  # File does not exist
    fi
}

# Kill already running processes
_ps=(waybar rofi swaync ags)
for _prs in "${_ps[@]}"; do
    if pidof "${_prs}" >/dev/null; then
        pkill "${_prs}"
    fi
done

# quit ags
ags -q
pkill -f "kitty-cava"

sleep 0.3
#Restart waybar
waybar &
sleep 0.3
KITTY_DISABLE_WAYLAND=1 kitty -c "~/.config/kitty/kitty-cava.conf" -o background_opacity=0.0 --name="kitty-cava" --class="kitty-cava" "/home/kofta/.config/hypr/cava.sh"

# relaunch swaync
sleep 0.5
swaync > /dev/null 2>&1 &

# relaunch ags
ags &

# Relaunching rainbow borders if the script exists
sleep 1
if file_exists "${UserScripts}/RainbowBorders.sh"; then
    ${UserScripts}/RainbowBorders.sh &
fi


exit 0
