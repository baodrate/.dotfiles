#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# https://stackoverflow.com/a/25515370
yell() { echo "$0: $*" >&2; }
die() { yell "$*"; exit 111; }
try() { "$@" || die "cannot ($?): $*"; }

source "${DIR}/sh-update-link.sh" || exit -1

required_vars=(DIR XDG_CONFIG_HOME BASE16_SHELL_HOOKS)
for i in "${required_vars[@]}"; do eval "val=\$$i"; if [ -z "$val" ]; then echo "$i is unset or empty"; exit -1; fi; done
[ -d "${XDG_CONFIG_HOME}/colors" ] || exit -1

current_theme_link="$XDG_CONFIG_HOME/colors/current_base16_theme"

debug() { echo "$1"; }

get_abs_path() { perl -MCwd -le 'print Cwd::abs_path(shift)' "$1" ; }

base16()
{
  local theme=$1

  echo "Changing base16: $theme"

  script="$XDG_CONFIG_HOME/colors/base16-shell/scripts/base16-${theme}.sh"
  [ -f "$script" ] || { echo "failed to find script ($script) for theme ($theme)" && return 1 ; }
  try source "$script"

  export BASE16_THEME="${theme}"

  # run shell hooks
  if [ -n "$BASE16_SHELL_HOOKS" ] && [ -d "${BASE16_SHELL_HOOKS}" ]; then
    failures=
    for hook in "$BASE16_SHELL_HOOKS"/*; do
      if [ -f "$hook" ] && [ -x "$hook" ] && hook_output=$($hook); then
        echo "Hook ran successfully: $(basename "$hook")${hook_output:+ ($hook_output)}"
      else
        echo "Hook failed: $hook ($hook_output)" 1>&2
        failures="$hook;$failures"
      fi
    done
    [ -z "$failures" ] || return 1
  fi
}

if [ -f "$current_theme_link" ] && source "$current_theme_link"; then
  script=$(get_abs_path "$current_theme_link")
  script_name=$(basename "$script" .sh)
  export BASE16_THEME=${script_name##base16-}
fi
