#!/bin/bash

start_tmux() {
  SESSION_NAME=$1
  PROJECT_DIR="$HOME/dev/$SESSION_NAME"

  if ! [ -d "$PROJECT_DIR" ]; then
    echo -e "$PROJECT_DIR: not a directory"
    exit 1
  fi

  if ! tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    # Create new session with first window for Neovim
    tmux new-session -d -s "$SESSION_NAME"
    tmux send-keys "cd $PROJECT_DIR && nvim && clear" C-m

    # Create second window with split panes
    tmux new-window -t "$SESSION_NAME:2" -n "Terminal"
    tmux select-layout even-vertical

    # Left pane
    tmux send-keys "cd $PROJECT_DIR && clear" C-m

    # Right pane
    tmux split-window -h
    if [ -f "$PROJECT_DIR/Cargo.toml" ]; then
      tmux send-keys "cd $PROJECT_DIR && bacon" C-m
    else
      tmux send-keys "cd $PROJECT_DIR && clear" C-m
    fi

    # Select first pane and go back to first window
    tmux select-pane -t 1
    tmux select-window -t "$SESSION_NAME:1"
  fi

  tmux attach-session -t "$SESSION_NAME"
}

# Main
if [ $# -eq 0 ]; then
  tmux attach
fi

start_tmux "$1"

# case "$1" in
  # *) start_tmux "$1"
    # ;;
# esac

