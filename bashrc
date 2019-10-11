#!/usr/bin/env bash

export BASH_ENV="$HOME/.bash_env"
[ -n "$BASH_ENV" ] && [ -r "$BASH_ENV" ] && source "$BASH_ENV"

[ -r "/etc/bashrc" ] && source "/etc/bashrc"
[ -r "/etc/bash.bashrc" ] && source "/etc/bash.bashrc"

alias sudo='/usr/bin/sudo'
impersonate() {
  local -r target_user=${1:?}
  shift
  args=("$@")

  if [ -z "${args[@]}" ] ; then
    args=(bash --login)
  fi

  echo "target_user $target_user"
  echo "args ${args[@]}"
  sudo -E -u ${target_user} "${args[@]}"
}

_gen_prompt() {
  local -r ANSI_NORMAL="$(tput sgr0)"
  local -r ANSI_BOLD="$(tput bold)"
  local -r ANSI_DIM="$(tput dim)"
  local -r ANSI_REVERSE="$(tput smso)"
  local -r ANSI_UNDERLINE="$(tput smul)"

  local -r ANSI_BLACK="$(tput setaf 0)"
  local -r ANSI_RED="$(tput setaf 1)"
  local -r ANSI_GREEN="$(tput setaf 2)"
  local -r ANSI_YELLOW="$(tput setaf 3)"
  local -r ANSI_BLUE="$(tput setaf 4)"
  local -r ANSI_MAGENTA="$(tput setaf 5)"
  local -r ANSI_CYAN="$(tput setaf 6)"
  local -r ANSI_WHITE="$(tput setaf 7)"

  local -r _PROMPT_SYM="\[${ANSI_BOLD}${ANSI_BLUE}\]»\[${ANSI_NORMAL}\]"
  local -r _PRE_PROMPT="\[${ANSI_NORMAL}\]»"
  local -r _HOSTNAME_STR="\[${ANSI_YELLOW}\]\h\[${ANSI_NORMAL}\]"
  local -r _USER_STR="\[${ANSI_GREEN}\]\u\[${ANSI_NORMAL}\]"
  local -r _PATH_STR="\[${ANSI_DIM}\][\w]\[${ANSI_NORMAL}\]"

  # -----------------
  # bash prompt (ps1)
  # -----------------

  read -r -d '' PROMPT_COMMAND <<EOF
    _ret=\$?
    if [ \$_ret != 0 ]; then
      _ret_str="\[${ANSI_RED}\][\${_ret}]\[${ANSI_NORMAL}\]"
    else
      _ret_str=""
    fi

    _path_str="[\[${ANSI_DIM}\]${PWD}]\[${ANSI_NORMAL}\]"
    case \$PWD in
      \$HOME)   _pwd="~";;
      \$HOME/*) _pwd="~\${PWD##\$HOME}";;
      *)        _pwd="\$PWD"
    esac

    case \$_pwd in
      */*) _path_str="[\[${ANSI_DIM}\]\${_pwd%/*}/\[${ANSI_NORMAL}\]\${_pwd##*/}]" ;;
      *) _path_str="[\${_pwd}]" ;;
    esac

    PS1="${_PRE_PROMPT} ${_HOSTNAME_STR}╺─╸\${_path_str}\${_ret_str} ${_PROMPT_SYM} "
EOF

  printf '%s' "$PROMPT_COMMAND"
}

export PROMPT_COMMAND="$(_gen_prompt)"

# ------------------------
# include other .d scripts
# ------------------------
for file in $HOME/.shrc.d/*; do
  if [ -x "$file" ]; then
    . "$file"
  fi
done
for file in $HOME/.bashrc.d/*; do
  if [ -x "$file" ]; then
    . "$file"
  fi
done

# -----------------------------------
# run bash_logout in non-login shells
# -----------------------------------
trap_exit() {
  source "$HOME/.bash_logout"
}
trap trap_exit EXIT
