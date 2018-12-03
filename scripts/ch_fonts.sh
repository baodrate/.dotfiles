#!/bin/sh

# parse arguments
# https://stackoverflow.com/a/31443098
while [ "$#" -gt 0 ]; do
  case "$1" in
    -f) font="$2"; shift 2;;
    -s) size="$2"; shift 2;;

    --font=*) font="${1#*=}"; shift 1;;
    --size=*) size="${1#*=}"; shift 1;;
    --fotn|--size) echo "$1 requires an argument" >&2; exit 1;;

    -*) echo "unknown option: $1" >&2; exit 1;;
    *) { [ -z "$font" ] && font="$1"; } || { [ -z "$size" ] && size="$1"; } || { echo "unexpected argument $1" && exit 1 ; }; shift 1;;
  esac
done

echo "printf \"%b\" \"\033]710;xft:${font:-fixed}:size=${size:-8}\033\\\""
printf "%b" "\033]710;xft:${font:-fixed}:size=${size:-8}\033\\"
echo "printf \"%b\" \"\033]711;xft:${font:-fixed}:size=${size:-8}:bold\033\\\""
printf "%b" "\033]711;xft:${font:-fixed}:size=${size:-8}:bold\033\\"
echo "printf \"%b\" \"\033]712;xft:${font:-fixed}:size=${size:-8}:italic\033\\\""
printf "%b" "\033]712;xft:${font:-fixed}:size=${size:-8}:italic\033\\"
echo "printf \"%b\" \"\033]713;xft:${font:-fixed}:size=${size:-8}:bold:italic\033\\\""
printf "%b" "\033]713;xft:${font:-fixed}:size=${size:-8}:bold:italic\033\\"
