#!/bin/sh

required_vars="SCRIPTS_DIR"
for i in $required_vars; do eval "val=\$$i"; if [ -z "${val:?}" ]; then echo "$i is unset or empty"; exit 1; fi; done

. "${SCRIPTS_DIR}/sh-find-relative-path.sh" || exit 1

get_abs_path() { perl -MCwd -le 'print Cwd::abs_path(shift)' "$1" ; }

pause() { while true; do sleep 1 ; done; }

get_original_dir() {
  [ -z "$1" ] && echo "No 1st (target_directory) argument supplied" && return 1;

  target_directory=$1

  target_file_dir=$(get_abs_path $target_directory)
  if [ -L $target_directory ]; then
    target_file_dir=$(get_abs_path $target_directory)
  fi

  echo "$target_directory"
}

get_ultimate_link() (
  [ -z "$1" ] && echo "No 1st (link) argument supplied" && return 1;

  link=$1

  cd `dirname $link`

  target=$(readlink $link)
  target_dir=$(cd `dirname $target` && pwd)
  target_name=`basename $target`
  target="$target_dir/$target_name"

  if [ -L "$target" ]; then
    echo `get_ultimate_link $target`; return $?
  else
    echo $link; return 0;
  fi
)

update_link() {
  [ -z "$1" ] && echo "No 1st (link_to_update) argument supplied" && return 1;
  [ -z "$2" ] && echo "No 2nd (source_file_path) argument supplied" && return 1;

  [ ! -e $link_to_update ] && echo "Link does not exist at expected: '$link_to_update'" && return 1;

  link_to_update=$1
  target_file_dir=$(dirname "${link_to_update}")
  target_file_name=$(basename "${link_to_update}")

  source_file_path=$2
  source_file_name=$(basename $source_file_path)

  if [ -L $link_to_update ]; then
    if [ ! -e $link_to_update ]; then
      echo "linked config ($link_to_update) is a broken link; not updating"; return 1
    fi

    target_file_dir=`get_abs_path $target_file_dir`
    link_to_update=$target_file_dir/$target_file_name

    # resolve until we get last link before actual file
    link_to_update=`get_ultimate_link $link_to_update`
  elif [ -e $link_to_update ]; then
    echo "existing config (${link_to_update}) is not a symlink; not updating"; return 1
  else
    if [ ! -d "$(dirname target_file_dir)" ]; then
      mkdir $target_file_dir || (echo "Failed to create dir $target_file_dir"; return 1)
    fi
  fi

  ln_target="$source_file_path"
  real_source_file_path=$(get_abs_path $source_file_path)

  if [ ! -e "$real_source_file_path" ]; then
    echo "Could not find source file at $real_source_file_path"6
    return 1
  fi

  ln_target=$(find_relative_path $(dirname "$link_to_update") "$real_source_file_path")

  if [ -d "$link_to_update" ]; then
    echo "link name: '$link_to_update' is an existing directory" 1>&2
    return 1
  else
    ln -sf "$ln_target" "$link_to_update" || (echo "failed to update link"; return 1)
  fi
}
