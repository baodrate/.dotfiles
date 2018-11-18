#!/bin/sh
SCRIPTS_DIR=${SCRIPTS_DIR:-"${HOME}/.scripts"}

if [ ! -d $SCRIPTS_DIR ]; then
  echo "SCRIPTS_DIR ($SCRIPTS_DIR) directory not found"; return -1
fi

. "$SCRIPTS_DIR/sh-find-relative-path.sh"

get_abs_path() { perl -MCwd -le 'print Cwd::abs_path(shift)' "$1" ; }

update_link() {
  [ -z "$1" ] && echo "No 1st (link_to_update) argument 1 supplied" && return -1;
  [ -z "$2" ] && echo "No 2nd (source_file_path) argument supplied" && return -1;

  link_to_update=$1
  target_file_dir=$(dirname "${link_to_update}")

  source_file_path=$2
  source_file_name=$(basename $source_file_path)

  if [ -L $link_to_update ]; then
    if [ ! -e $link_to_update ]; then
      echo "linked config ($link_to_update) is a broken link; not updating"; return -1
    fi

    cd "$(dirname $link_to_update)"
    link_to_update_ORIG=$(readlink $link_to_update)
    while [ -L $link_to_update_ORIG ]; do
      cd "$(dirname $link_to_update_ORIG)"
      link_to_update=$(pwd)/$(basename $link_to_update_ORIG)
      link_to_update_ORIG=$(readlink $link_to_update)
    done
  elif [ -e $link_to_update ]; then
    echo "existing config (${link_to_update}) is not a symlink; not updating"; return -1
  else
    if [ ! -d "$(dirname target_file_dir)" ]; then
      mkdir $target_file_dir || (echo "Failed to create dir $target_file_dir"; return -1)
    fi
  fi

  ln_target="$source_file_path"
  real_source_file_path=$(get_abs_path $source_file_path)

  if [ ! -e "$real_source_file_path" ]; then
    echo "Could not find source file at $(dirname $link_to_update_ORIG)/$source_file_name"
    return -1
  fi

  ln_target="$(find_relative_path $(dirname $link_to_update) $real_source_file_path)"

  ln -sTf "$ln_target" "$link_to_update" || (echo "failed to update link"; return -1)
}
