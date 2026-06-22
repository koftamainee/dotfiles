#!/bin/sh

if makoctl mode | grep -q dnd; then
    makoctl mode -r dnd
    notify-send "Disabling Do Not Disturb"
else
    notify-send "Enabling Do Not Disturb"
    sleep 1
    makoctl mode -a dnd
fi
