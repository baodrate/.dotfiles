#!/usr/bin/env bash
# https://stackoverflow.com/a/25515370
yell() { echo "$0: $*" >&2; }
die() { yell "$*"; return -1; }
try() { "$@" || die "cannot ($?): $*"; }

current_theme_link="${XDG_CONFIG_HOME:-$HOME/.config}/colors/current_base16_theme"

get_abs_path() { perl -MCwd -le 'print Cwd::abs_path(shift)' "$1" ; }

# alias base16="$SHELL ${XDG_CONFIG_HOME:-$HOME/.config}/colors/base16.sh"
alias base16="${XDG_CONFIG_HOME:-$HOME/.config}/colors/base16.sh"

if [ -z "$BASE16_THEME" ]; then
  if [[ -h "$current_theme_link" ]] ; then
    script_path="$(get_abs_path $current_theme_link)"
    if [[ -e "$script_path" ]]; then
      script_name=$(basename "$script_path" .sh)
      BASE16_THEME=${script_name##base16-}
    else
      echo "could not find script at $script_path" >&2
    fi
  else
    echo "BASE16_THEME not set and could not find theme link at $current_theme_link" >&2
  fi
fi

if [ -n "$BASE16_THEME" ]; then
  export BASE16_THEME=${BASE16_THEME}
  . ${XDG_CONFIG_HOME:-$HOME/.config}/colors/base16-shell/scripts/base16-${BASE16_THEME}.sh
fi
