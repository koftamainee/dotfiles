#!/bin/bash

start_tmux() {
  SESSION_NAME=$1

  if ! [ -d "$HOME/dev/$SESSION_NAME" ]; then
    echo -e "$HOME/dev/$SESSION_NAME: not a directory"
    exit 1
  fi

  if ! tmux has-session -t "$SESSION_NAME" 2>/dev/null; then

    tmux new-session -d -s "$SESSION_NAME"

    tmux send-keys "cd ~/dev/$SESSION_NAME/ && nvim && clear" C-m

    tmux new-window -t "$SESSION_NAME:2" -n "Terminal"

    tmux select-layout even-vertical

    tmux send-keys "cd ~/dev/$SESSION_NAME && clear" C-m

    tmux split-window -h

    tmux send-keys "cd ~/dev/$SESSION_NAME && clear" C-m

    tmux select-pane -t 1

    tmux select-window -t "$SESSION_NAME:1"
  fi

  tmux attach-session -t "$SESSION_NAME"
}

# Main
if [ $# -eq 0 ]; then
  tmux attach
fi

case "$1" in
  "labs") start_tmux rgu/rgu-labs
    ;;
  *) start_tmux "$1"
    ;;
esac

