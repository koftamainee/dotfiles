#!/bin/bash

PROGRAM="activate-linux"

if pkill -0 -x "$PROGRAM" 2>/dev/null; then
    pkill -x "$PROGRAM"
else
    activate-linux &
fi
