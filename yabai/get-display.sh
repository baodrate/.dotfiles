#!/bin/bash
read -r -d '' help_menu <<EOF
USAGE
  $(basename "$0") [-h] [DIRECTION]

POSITIONAL ARGUMENTS
    DIRECTION (optional)
        A direction to get a display adjacent to the currently focused one
        Possible values:
            l / left
            r / right

OPTIONS
    -h          show help dialog
EOF

while getopts ':h' option; do
  case "$option" in
    h) echo "$help_menu"
       exit
       ;;
    :) printf "missing argument for -%s\n" "$OPTARG" >&2
       echo "$help_menu" >&2
       exit 1
       ;;
   [?]) printf "illegal option: -%s\n" "$OPTARG" >&2
       echo "$help_menu" >&2
       exit 1
       ;;
  esac
done
shift $((OPTIND - 1))

debug() {
    echo "$@" >&2
}
error() {
    debug "$@"
}

get_display_for_space() {
    local space_index=${1:?}

    local display_index="$(yabai -m query --displays | jq --argjson idx "$space_index" '.[]|select(.spaces|any(.==$idx)).index')"

    debug "index of display with space $space_index: $display_index" >&2
    printf '%s' "$display_index"
}

get_current_space() {
    local space_index=$(yabai -m query --spaces | jq -cr '.[]|select(.focused!=0).index')

    debug "index of currently focused space: $space_index" >&2
    printf '%s' "$space_index"
}

get_displays_by() {
    yabai -m query --displays | jq -cr ".|sort_by(${1:?})|.[].index"
}

get_next_display() {
    local focused_display_idx="$(get_display_for_space "$(get_current_space)")"

    local prev_idx=
    while read display_idx; do
        if [ "$prev_idx" = "$focused_display_idx" ]; then
            echo "$display_idx"
            return 0
        fi
        prev_idx="$display_idx"
    done

    return 1
}

main() {
    direction=${1}

    if [ -n "$direction" ] ; then
        shopt -s nocasematch
        case "$direction" in
            l|left) debug "Finding left display"
                get_displays_by "-.frame.x, .frame.y" | get_next_display
                ;;
            r|right) debug "Finding right display"
                get_displays_by ".frame.x, .frame.y" | get_next_display
                ;;
            [?]) error "invalid direction: $direction"
                exit 1
                ;;
        esac
        exit
    else
        printf '%s' "$(get_display_for_space "$(get_current_space)")"
    fi
}

main "$@"
