#!/bin/bash

SCRIPTSDIR=$HOME/.config/hypr/scripts

# Define file_exists function
file_exists() {
    if [ -e "$1" ]; then
        return 0  # File exists
    else
        return 1  # File does not exist
    fi
}

# Kill already running processes
_ps=(rofi)
for _prs in "${_ps[@]}"; do
    if pidof "${_prs}" >/dev/null; then
        pkill "${_prs}"
    fi
done

# Pywal refresh
${SCRIPTSDIR}/PywalSwww.sh &

# Relaunching rainbow borders if the script exists
sleep 1
if file_exists "${SCRIPTSDIR}/RainbowBorders.sh"; then
    ${SCRIPTSDIR}/RainbowBorders.sh &
fi

# for cava-pywal (note, need to manually restart cava once wallpaper changes)
ln -sf "$HOME/.cache/wal/cava-colors" "$HOME/.config/cava/config" || true

exit 0