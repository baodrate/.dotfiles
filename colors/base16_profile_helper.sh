#!/usr/bin/env bash

required_vars=(SCRIPTS_DIR COLORS_DIR)
for i in "${required_vars[@]}"; do eval "val=\$$i"; if [ -z "$val" ]; then echo "$i is unset or empty"; exit -1; fi; done

. "${SCRIPTS_DIR}/sh-update-link.sh" || exit -1

current_theme_link="$COLORS_DIR/current_base16_theme"

debug() { echo "$1"; }

_base16()
{
  local script=$1
  local theme=$2
  if [[ -f "$script" ]]; then
    if source $script && update_link "$current_theme_link" "$script"; then
      export BASE16_THEME=${theme}
      if [ -n "$BASE16_SHELL_HOOKS" ] && [ -d "${BASE16_SHELL_HOOKS}" ]; then
        for hook in $BASE16_SHELL_HOOKS/*; do
          if [ -f "$hook" ] && [ -x "$hook" ] && "$hook"; then
            echo "Hook ran successfully: $hook"
          else
            echo "Hook failed: $hook" 1>&2
            return 1
          fi
        done
      fi
    else
      return 1
    fi
  fi
}

for script in $BASE16_SHELL/scripts/base16*.sh; do
  script_name=${script##*/}
  script_name=${script_name%.sh}
  theme=${script_name#*-}
  func_name="base16_${theme}"
  alias $func_name="_base16 ${script} $theme"
done;

if [ -f "$current_theme_link" ]; then
  script_name=$(basename "$(perl -MCwd -le 'print Cwd::abs_path(shift)' "$current_theme_link")" .sh)
  export BASE16_THEME=${script_name//base16-/}
  source "$BASE16_SHELL/scripts/$script_name.sh"
fi
