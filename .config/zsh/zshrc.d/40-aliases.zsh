#!/bin/zsh

alias open='xdg-open'

ssht() {
  ssh -t $@ "sh -c 'tmux a || tmux'"
}

startsway() {
  if [ -f "${XDG_CONFIG_HOME:-$HOME/.config}/sway/env" ] ; then
    export $(grep -Ev '^#' "${XDG_CONFIG_HOME:-$HOME/.config}/sway/env" | xargs)
  fi

  exec systemd-cat --identifier=sway --priority=info --stderr-priority=warning sway
}

alias cfg='git --git-dir="$HOME"/.dotfiles/ --work-tree="$HOME"'

alias backup='rsync --archive --numeric-ids --hard-links --partial --xattrs --partial --info=progress2'

# alias sudo='sudo '
