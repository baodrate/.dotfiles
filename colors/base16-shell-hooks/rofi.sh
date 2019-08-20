#!/bin/sh
required_vars="XDG_CONFIG_HOME BASE16_THEME"
for i in $required_vars; do eval "val=\$$i"; if [ -z "$val" ]; then echo "$i is unset or empty"; exit -1; fi; done
[ -d "$XDG_CONFIG_HOME/colors" ] || exit -1

. "$XDG_CONFIG_HOME/colors/sh-update-link.sh" || exit -1

link_to_update=$XDG_CONFIG_HOME/rofi/base16.conf
source_file_path=$XDG_CONFIG_HOME/colors/base16-rofi/themes/base16-$BASE16_THEME.config

update_link "$link_to_update" "$source_file_path"
