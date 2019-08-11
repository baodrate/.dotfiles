#!/usr/bin/env bash
# https://stackoverflow.com/a/25515370
yell() { echo "$0: $*" >&2; }
die() { yell "$*"; return -1; }
try() { "$@" || die "cannot ($?): $*"; }

# https://stackoverflow.com/a/11097703
curr_shell=$(ps -ocomm= -q $$)
if [ "$curr_shell" = "zsh" ]; then
  file_name=${(%):-%x}
elif [ "$curr_shell" = "bash" ]; then
  file_name=${BASH_SOURCE[0]}
else
  die "don't recognize running shell: $curr_shell"
fi
script_dir="$( cd "$( dirname "$file_name" )" && pwd )"
# script_dir="$( cd "$( dirname "$file_name" )" >/dev/null 2>&1 && pwd )"

source "${script_dir}/sh-update-link.sh" >&2 || die "couldn't source script: ${script_dir}/sh-update-link.sh" 

required_vars=(script_dir XDG_CONFIG_HOME BASE16_SHELL_HOOKS)
for i in "${required_vars[@]}"; do eval "val=\$$i"; try [ ! -z "$val" ]; done
try [ -d "${XDG_CONFIG_HOME}/colors" ]

current_theme_link="$XDG_CONFIG_HOME/colors/current_base16_theme"

debug() { echo "$1"; }

get_abs_path() { perl -MCwd -le 'print Cwd::abs_path(shift)' "$1" ; }

base16()
{
  local theme=$1

  echo "Changing base16: $theme"

  script="$XDG_CONFIG_HOME/colors/base16-shell/scripts/base16-${theme}.sh"
  [ -f "$script" ] || { echo "failed to find script ($script) for theme ($theme)" && return 1 ; }
  source "$script" >&2 || die "couldn't source script: $script"

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
