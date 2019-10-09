#!/usr/bin/env bash

# [ -r "/etc/bashrc" ] && source "/etc/bashrc"
# [ -r "/etc/bash.bashrc" ] && source "/etc/bash.bashrc"

# ------------------------
# include other .d scripts
# ------------------------
for file in $HOME/.bashrc.d/*; do
  if [ -x "$file" ]; then
    . "$file"
  fi
done

# -----------------------------------
# run bash_logout in non-login shells
# -----------------------------------
trap_exit() {
  source "$HOME/.bash_logout"
}
trap trap_exit EXIT
