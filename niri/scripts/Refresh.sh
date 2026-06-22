SCRIPTSDIR=$HOME/.config/niri/scripts

file_exists() {
    if [ -e "$1" ]; then
        return 0  # File exists
    else
        return 1  # File does not exist
    fi
}

# Kill already running processes
_ps=(waybar rofi swaync)
for _prs in "${_ps[@]}"; do
    if pidof "${_prs}" >/dev/null; then
        pkill "${_prs}"
    fi
done

# quit ags
ags -q

# sleep 0.3
#Restart waybar
waybar &
# sleep 0.3
sleep 1 && bash ~/.config/niri/cava.sh

# relaunch swaync
# sleep 0.5
swaync > /dev/null 2>&1 &


exit 0
