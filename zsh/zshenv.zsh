export SHELL="zsh"

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# fix for https://github.com/swaywm/sway/issues/595
export _JAVA_AWT_WM_NONREPARENTING=1

export PATH="$HOME/.scripts:$(getconf PATH)"
export PATH="/usr/local/bin:$PATH"

if (( $+commands[nvim] )) ; then
  export VISUAL=nvim
  export NVIM_TUI_ENABLE_TRUE_COLOR=1
elif (( $+commands[vim] )) ; then
  export VISUAL=vim
else
  echo 'could not find neovim or vim; not setting $VISUAL'
fi

if (( $+commands[cargo] )) ; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi
if (( $+commands[npm] )) ; then
  export npm_config_prefix=~/.node_modules
  export PATH="$npm_config_prefix/bin:$PATH"
fi
if (( $+commands[python2] )) ; then
  export PATH="$(python2 -m site --user-base)/bin:$(python2 -m site --user-site):$PATH"
fi
if (( $+commands[python3] )) ; then
  export PATH="$(python3 -m site --user-base)/bin:$(python3 -m site --user-site):$PATH"
fi


unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

# ====
# WORK
# ====
export AWS_SDK_CPP_DIR="/usr/local/lib/aws-sdk-cpp"

# ===
# MAC
# ===
ulimit -n 32768
# export AWS_SDK_CPP_DIR="/usr/local/lib"

export DOCKER_TLS_VERIFY="1"
export DOCKER_HOST="tcp://192.168.99.102:2376"
export DOCKER_CERT_PATH="/Users/baot/.docker/machine/machines/doctholomew"
export DOCKER_MACHINE_NAME="doctholomew"
