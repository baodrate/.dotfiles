#!/usr/bin/env bash

required_vars=(SCRIPTS_DIR XDG_CONFIG_HOME BASE16_SHELL BASE16_SHELL_HOOKS)
for i in "${required_vars[@]}"; do eval "val=\$$i"; if [ -z "$val" ]; then echo "$i is unset or empty"; exit -1; fi; done
[ -d "$XDG_CONFIG_HOME"/colors ] || exit -1

source "${SCRIPTS_DIR}/sh-update-link.sh" || exit -1

current_theme_link="$XDG_CONFIG_HOME/colors/current_base16_theme"

debug() { echo "$1"; }

base16()
{
  local script=$1
  local theme=$2
  if [[ -f "$script" ]]; then
    if source "$script" && update_link "$current_theme_link" "$script"; then
      export BASE16_THEME=${theme}
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
        [ -z "$failures" ] && return 0 || return 1
      fi
    else
      return 1
    fi
  fi
}

if [ -f "$current_theme_link" ]; then
  script=$(perl -MCwd -le 'print Cwd::abs_path(shift)' "$current_theme_link")
  script_name=$(basename "$script" .sh)
  export BASE16_THEME=${script_name//base16-/}
  source "$BASE16_SHELL/scripts/$script_name.sh"
fi
