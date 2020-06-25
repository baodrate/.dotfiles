#!/bin/sh

[ ! -r /etc/profile ] || . /etc/profile

# ============
# update paths
# ============
# ==> setup PATH variable

prependpath () {
    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
            PATH="$1${PATH:+:$PATH}"
    esac
}

# ==> rust
prependpath "$CARGO_HOME/bin"

# ==> python
export PYTHONUSERBASE=${PYTHONUSERBASE:-"${XDG_DATA_HOME:-$HOME/.local/share}/python"}
prependpath "$PYTHONUSERBASE/bin"

prependpath "$HOME/.poetry/bin"

export PYENV_ROOT="${XDG_DATA_HOME:-$HOME/.local/share}/pyenv"
prependpath "$PYENV_ROOT/bin"

# ==> npm
export npm_config_prefix="${XDG_DATA_HOME:-$HOME/.local/share}/npm"
export npm_config_cache="${XDG_CACHE_HOME:-$HOME/.cache}/npm"
prependpath "$npm_config_prefix/bin"

# ==> generic
prependpath "$HOME/bin"

unset prependpath
export PATH

# =======================
# inlude other conf files
# =======================
if [ -d "$HOME"/.profile.d/ ] ; then
  for profile in "$HOME"/.profile.d/*; do
    [ -r "$profile" ] && . "$profile"
  done
  unset profile
fi
