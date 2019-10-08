#!/usr/bin/env bash

[ -r "/etc/bashrc" ] && source "/etc/bashrc"
[ -r "/etc/bash.bashrc" ] && source "/etc/bash.bashrc"

[ -r ~/.env ] && source ~/.env

# ==============================================================================
# inlude other .d scripts
# ==============================================================================
for file in $HOME/.bashrc.d/*; do
  if [ -r "$file" ]; then
    . "$file"
  fi
done

# ==============================================================================
# misc
# ==============================================================================

# -----------------------------------
# run bash_logout in non-login shells
# -----------------------------------
trap_exit() {
  source "$HOME/.bash_logout"
}
trap trap_exit EXIT
