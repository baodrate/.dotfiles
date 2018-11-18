#!/bin/sh

required_vars=(SCRIPTS_DIR)
for i in ${required_vars[@]}; do eval "val=\$$i"; if [ -z "$val" ]; then echo "$i is unset or empty"; exit -1; fi; done

. "${SCRIPTS_DIR}/sh-find-relative-path.sh" || exit -1

get_abs_path() { perl -MCwd -le 'print Cwd::abs_path(shift)' "$1" ; }

update_link() {
  [ -z "$1" ] && echo "No 1st (link_to_update) argument 1 supplied" && return -1;
  [ -z "$2" ] && echo "No 2nd (source_file_path) argument supplied" && return -1;

  link_to_update=$1
  target_file_dir=$(dirname "${link_to_update}")
  target_file_name=$(basename "${link_to_update}")

  source_file_path=$2
  source_file_name=$(basename $source_file_path)

  if [ -L $link_to_update ]; then
    if [ ! -e $link_to_update ]; then
      echo "linked config ($link_to_update) is a broken link; not updating"; return -1
    fi

    if [ -L $target_file_dir ]; then
      target_file_dir=$(get_abs_path $target_file_dir)
      cd "$target_file_dir"
    fi

    link_to_update=$target_file_dir/$target_file_name

    # resolve until we get last link before actual file
    link_to_update_ORIG=$(readlink $link_to_update)
    while [ -L $link_to_update_ORIG ]; do
      target_file_dir=$(dirname "${link_to_update_ORIG}")
      target_file_name=$(basename "${link_to_update_ORIG}")
      cd "$target_file_dir"
      link_to_update=$(pwd)/$target_file_name
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
    echo "Could not find source file at $real_source_file_path"
    return -1
  fi

  ln_target="$(find_relative_path $(dirname $link_to_update) $real_source_file_path)"

  ln -sTf "$ln_target" "$link_to_update" || (echo "failed to update link"; return -1)
}
