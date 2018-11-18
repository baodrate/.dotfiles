#!/bin/sh

SCRIPTS_DIR=${SCRIPTS_DIR:-"${HOME}/.scripts"}

if [ ! -d $SCRIPTS_DIR ]; then
  echo "SCRIPTS_DIR ($SCRIPTS_DIR) directory not found"; exit -1
fi

. "$SCRIPTS_DIR/sh-update-link.sh"

CONFIG_DIR=${CONFIG_DIR:-"$HOME/.config"}
COLORS_DIR=${COLORS_DIR:-"$HOME/.colors"}

link_to_update=$CONFIG_DIR/rofi/config
source_file_path=$COLORS_DIR/base16-rofi/themes/base16-$BASE16_THEME.config

update_link "$link_to_update" "$source_file_path"

echo 'Rofi theme updated'
