#!/bin/sh

# gpgconf --launch gpg-agent

# export SSH_AUTH_SOCKET=$HOME/.gnupg/S.gpg-agent.ssh
# export SSH_AUTH_SOCK=$HOME/.gnupg/S.gpg-agent.ssh

[ ! -r "/etc/profile" ] || . "/etc/profile"

# =======================
# inlude other conf files
# =======================
for file in $HOME/.profile.d/*; do
  if [ -x "$file" ]; then
    . "$file"
  fi
done

# ============
# update paths
# ============
# ==> setup PATH variable

pathmunge () {
  case ":${PATH}:" in
    *:"$1":*)
      ;;
    *)
      if [ "$2" = "after" ] ; then
        PATH="${PATH:+"$PATH:"}$1"
      else
        PATH="$1${PATH:+":$PATH"}"
      fi
  esac
}

[ ! -d "$SCRIPTS_DIR" ] || pathmunge "$SCRIPTS_DIR"

# ==> generic
[ ! -d "$HOME/.local/bin" ] || pathmunge "$HOME/.local/bin"

# ==> rust
[ ! -d "$HOME/.cargo/bin" ] || pathmunge "$HOME/.cargo/bin"

# ==> python
export PYTHONUSERBASE=${PYTHONUSERBASE:-"$HOME/.local"}
[ ! -d "$PYTHONUSERBASE/bin" ] || pathmunge "$PYTHONUSERBASE/bin"
[ ! -d "$HOME/.poetry/bin" ] || pathmunge "$HOME/.poetry/bin"

export PYENV_ROOT="$HOME/.pyenv"
[ ! -d "$PYENV_ROOT/bin" ] || pathmunge "$PYENV_ROOT/bin"

# ==> npm
export npm_config_prefix="$XDG_DATA_HOME/npm"
export npm_config_cache="$XDG_CACHE_HOME/npm"
[ ! -d "$npm_config_prefix" ] || pathmunge "$npm_config_prefix/bin"

unset pathmunge
export PATH
