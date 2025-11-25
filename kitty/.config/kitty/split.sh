#!/bin/bash

# Kill existing session if it exists
tmux kill-session -t split-term 2>/dev/null

# Create a named pipe for output
PIPE="/tmp/tmux-output-$$"
mkfifo "$PIPE"

# Start new tmux session
tmux new-session -d -s split-term

# Split window (top 75%, bottom 25%)
tmux split-window -v -p 25

# Top pane: continuously read from the pipe
tmux send-keys -t 0 "tail -f $PIPE" C-m

# Bottom pane: wrap the shell to tee output to the pipe
tmux send-keys -t 1 "exec &> >(tee $PIPE); exec zsh" C-m

# Select bottom pane for input
tmux select-pane -t 1

# Attach to session
tmux attach-session -t split-term
