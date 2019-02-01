#!/bin/sh

required_vars="SCRIPTS_DIR XDG_CONFIG_HOME BASE16_THEME"
for i in $required_vars; do eval "val=\$$i"; if [ -z "$val" ]; then echo "$i is unset or empty"; exit -1; fi; done
[ -d "$XDG_CONFIG_HOME"/colors ] || exit -1

rm $XDG_CONFIG_HOME/nvim/colors/base16-*.vim
ln -s $XDG_CONFIG_HOME/colors/base16-vim/colors/base16-BASE16_THEME.vim
