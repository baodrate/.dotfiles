#!/usr/bin/env bash

SCRIPTS_DIR=${SCRIPTS_DIR:-"${HOME}/.scripts"}
if [ ! -d $SCRIPTS_DIR ]; then
  echo "SCRIPTS_DIR ($SCRIPTS_DIR) directory not found"; exit -1
fi

. "$SCRIPTS_DIR/sh-update-link.sh"

CONFIG_DIR=${CONFIG_DIR:-"$HOME/.config"}
COLORS_DIR=${COLORS_DIR:-"$HOME/.colors"}

BASE16_SHELL=$(dirname ${(%):-%x})/base16-shell

if [ -f ~/.base16_theme ]; then
  script_name=$(basename "$(perl -MCwd -le 'print Cwd::abs_path(shift)' ~/.base16_theme)" .sh)
  export BASE16_THEME=${script_name}
  source ~/.base16_theme
fi

_base16()
{
  local script=$1
  local theme=$2
  [ -f $script ] && . $script

  update_link "$HOME/.base16_theme" "$script"
  [ $? ] || return 01
  export BASE16_THEME=${theme}
  if [ -n ${BASE16_SHELL_HOOKS:+s} ] && [ -d "${BASE16_SHELL_HOOKS}" ]; then
    for hook in $BASE16_SHELL_HOOKS/*; do
      [ -f "$hook" ] && [ -x "$hook" ] && "$hook"
    done
  fi
}
for script in $BASE16_SHELL/scripts/base16*.sh; do
  script_name=${script##*/}
  script_name=${script_name%.sh}
  theme=${script_name#*-}
  func_name="base16_${theme}"
  alias $func_name="_base16 ${script} $theme"
done;
