#!/bin/sh
PARENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

required_vars=(PARENT_DIR XDG_CONFIG_HOME BASE16_THEME)
for i in "${required_vars[@]}"; do eval "val=\$$i"; if [ -z "$val" ]; then echo "$i is unset or empty"; exit -1; fi; done
[ -d "$XDG_CONFIG_HOME"/colors ] || exit -1

. "${PARENT_DIR}/sh-find-relative-path.sh" || exit -1

base16_vim_dir=$XDG_CONFIG_HOME/colors/base16-vim/colors
nvim_colors_dir=$XDG_CONFIG_HOME/nvim/colors

find $nvim_colors_dir -name 'base16-*.vim' -delete
ln -s ../../colors/base16-vim/colors/base16-$BASE16_THEME.vim $nvim_colors_dir/
