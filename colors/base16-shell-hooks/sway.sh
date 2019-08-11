#!/bin/sh
PARENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

required_vars=(PARENT_DIR XDG_CONFIG_HOME BASE16_THEME)
for i in "${required_vars[@]}"; do eval "val=\$$i"; if [ -z "$val" ]; then echo "$i is unset or empty"; exit -1; fi; done
[ -d "$XDG_CONFIG_HOME"/colors ] || exit -1

. "${PARENT_DIR}/sh-update-link.sh" || exit -1

link_to_update=$XDG_CONFIG_HOME/sway/config.d/base16-colors.config
source_file_path=$XDG_CONFIG_HOME/colors/base16-i3/colors/base16-$BASE16_THEME.config

update_link "$link_to_update" "$source_file_path"
