#!/usr/bin/env bash

dir="$(emacsclient --eval '(with-current-buffer (window-buffer (selected-window)) default-directory)' | sed -e 's/^"//' -e 's/"$//')"

"$EXPLORER" "$dir"
ghostty --working-directory="$dir"

emacsclient --eval "(message \"Opened ghostty in %s\" \"$dir\")" >/dev/null
