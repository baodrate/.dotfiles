#!/usr/bin/env bash

export BASH_ENV="$HOME/.bash_env"
[ -r "$BASH_ENV" ] && source "$BASH_ENV"

[ -r ~/.bashrc ] && source ~/.bashrc

[ -r ~/.profile ] && . ~/.profile

for file in $HOME/.bash_profile.d/*; do
  if [ -x "$file" ]; then
    . "$file"
  fi
done
