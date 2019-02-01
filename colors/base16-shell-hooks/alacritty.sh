#!/bin/sh

required_vars="SCRIPTS_DIR XDG_CONFIG_HOME BASE16_THEME"
for i in $required_vars; do eval "val=\$$i"; if [ -z "$val" ]; then echo "$i is unset or empty"; exit -1; fi; done
[ -d "$XDG_CONFIG_HOME"/colors ] || exit -1

. "${SCRIPTS_DIR}/sh-update-link.sh" || exit -1

link_to_update=$XDG_CONFIG_HOME/alacritty/alacritty.d/base16-colors.yml
source_file_path=$XDG_CONFIG_HOME/colors/base16-alacritty/colors/base16-$BASE16_THEME-256.yml

update_link "$link_to_update" "$source_file_path"

cat "$XDG_CONFIG_HOME/alacritty/alacritty.d/alacritty.base.yml" "$link_to_update" > "$XDG_CONFIG_HOME/alacritty/alacritty.yml"
