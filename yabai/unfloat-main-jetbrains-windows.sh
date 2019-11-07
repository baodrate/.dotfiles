#!/usr/bin/env bash

get_all_windows() {
  yabai -m query --windows
}

is_first_window_for_app() {
  get_all_windows | jq -er "map(select(.id == ${1:?}))[0] as \$curr_window
    | map(select(.pid == \$curr_window.pid))
    | sort_by(.id)[0] as \$first_window
    | ( \$curr_window.title | startswith(\"Welcome to \") | not )
      and
      ( \$curr_window.title != \"Tip of the Day\" )
      and
      (
        ( \$first_window.id == \$curr_window.id )
        or
        ( \$first_window.subrole == \$curr_window.role and \$first_window.subrole == \$curr_window.role )
      )"
}

if is_first_window_for_app "$YABAI_WINDOW_ID" > /dev/null ; then
  # rule sets windows to floating by default, so reset to tiled
  yabai -m window "$YABAI_WINDOW_ID" --toggle float
  echo "set jetbrains window ($YABAI_WINDOW_ID) as tiled: $?"
else
  # yabai -m window --focus "$YABAI_WINDOW_ID"
  echo "set jetbrains window ($YABAI_WINDOW_ID) as floating: $?"
fi
