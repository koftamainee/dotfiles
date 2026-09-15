#!/usr/bin/env bash
#
EXPLORER=nautilus

dir="$(emacsclient --eval '(with-current-buffer (window-buffer (selected-window)) default-directory)' | sed -e 's/^"//' -e 's/"$//')"

"$EXPLORER" "$dir"

emacsclient --eval "(message \"opened $EXPLORER in %s\" \"$dir\")" >/dev/null
