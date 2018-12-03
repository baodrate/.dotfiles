#!/bin/sh

required_vars="SCRIPTS_DIR COLORS_DIR CONFIG_DIR BASE16_THEME"
for i in $required_vars; do eval "val=\$$i"; if [ -z "$val" ]; then echo "$i is unset or empty"; exit -1; fi; done

. "${SCRIPTS_DIR}/sh-update-link.sh" || exit -1

link_to_update=$CONFIG_DIR/alacritty/alacritty.d/base16-colors.yml
source_file_path=$COLORS_DIR/base16-alacritty/colors/base16-$BASE16_THEME-256.yml

update_link "$link_to_update" "$source_file_path"

cat "$CONFIG_DIR/alacritty/alacritty.d/alacritty.base.yml" "$link_to_update" > "$CONFIG_DIR/alacritty/alacritty.yml"

