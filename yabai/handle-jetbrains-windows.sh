#!/usr/bin/env bash

if yabai -m query --windows | jq -er 'map(select(.id == (env.YABAI_WINDOW_ID|tonumber)))[0] as $curr_window
  | map(select(.pid == $curr_window.pid))
  | sort_by(.id)[0] as $first_window
  | ( $first_window.id == env.YABAI_WINDOW_ID or ($first_window.subrole == $curr_window.role and $first_window.subrole == $curr_window.role) )' >  /dev/null
then
  yabai -m window "${YABAI_WINDOW_ID}" --toggle float
else
  yabai -m window --focus "${YABAI_WINDOW_ID}"
fi
