#!/usr/bin/env sh

# the window_created signal sets $1 to process id and $2 to window id 
# you can delay with a "sleep 0.1" here if needed

yabai -m query --windows --window "${2}" | jq -re '.app | startswith("Firefox")' >/dev/null && \
yabai -m window "${2}" --resize top_right:-1:-1 && \
yabai -m window "${2}" --resize top_right:1:1 && \
yabai -m window "${2}" --resize bottom_left:-1:-1 && \
yabai -m window "${2}" --resize bottom_left:1:1
