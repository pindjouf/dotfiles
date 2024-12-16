#!/bin/bash

STATE_FILE="/tmp/nerd_dictation_state"

if [ ! -f "$STATE_FILE" ]; then
    echo 0 > "$STATE_FILE"
fi

current_state=$(cat "$STATE_FILE")

dots=("" "." ".." "...")

if pgrep -f "/usr/local/bin/nerd-dictation" > /dev/null; then
    echo "{\"text\":\"  AI: Listening${dots[$current_state]}\", \"class\":\"listening\"}"
    
    next_state=$(( (current_state + 1) % 4 ))
    echo $next_state > "$STATE_FILE"
else
    echo "{\"text\":\"🔇 AI: IDLE\", \"class\":\"idle\"}"
    echo 0 > "$STATE_FILE"
fi
