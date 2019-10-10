#!/usr/bin/env bash

[ -r ~/.bashrc ] && source ~/.bashrc

[ -r ~/.profile ] && . ~/.profile

for file in $HOME/.bash_profile.d/*; do
  if [ -x "$file" ]; then
    . "$file"
  fi
done
