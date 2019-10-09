#!/usr/bin/env zsh
[[ -r ~/.env ]] && emulate sh -c ". ~/.env"

(( ${+ZDOTDIR} )) || export ZDOTDIR="${XDG_CONFIG_HOME:-"$HOME/.config"}/zsh"
. ${ZDOTDIR:-$HOME}/.zshenv
