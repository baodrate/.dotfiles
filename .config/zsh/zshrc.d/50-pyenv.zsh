#!/bin/zsh

export PATH="${XDG_DATA_HOME:-$HOME/.local/share}/pyenv/shims:${PATH}"
export PYENV_SHELL=nvim
command pyenv rehash 2>/dev/null
pyenv() {
  local command
  command="${1:-}"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  activate|deactivate|rehash|shell)
    eval "$(pyenv "sh-$command" "$@")";;
  *)
    command pyenv "$command" "$@";;
  esac
}
