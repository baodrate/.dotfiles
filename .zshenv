#!/bin/zsh
[[ -r ~/.profile ]] && emulate sh -c '. ~/.profile'

ZDOTDIR=${XDG_CONFIG_HOME:-$HOME/.config}/zsh
[ -f $ZDOTDIR/.zshenv ] && . $ZDOTDIR/.zshenv
