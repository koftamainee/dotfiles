#!/bin/bash
if pgrep "mpv"; then
  pkill mpv
else
  mpv --no-vid "https://www.youtube.com/watch?v=jfKfPfyJRdk"
fi

