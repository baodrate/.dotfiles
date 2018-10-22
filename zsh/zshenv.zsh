export SHELL="zsh"

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export PATH="$HOME/.scripts:$(getconf PATH)"
export PATH="/usr/local/bin:$PATH"

if command -v nvim 1>/dev/null 2>&1; then
  export VISUAL=nvim
  export NVIM_TUI_ENABLE_TRUE_COLOR=1
elif command -v vim 1>/dev/null 2>&1; then
  export VISUAL=vim
else
  echo 'could not find neovim or vim; not setting $VISUAL'
fi

if command -v brew 1>/dev/null 2>&1; then
  export CFLAGS="-I$(brew --prefix openssl)/include"
  export LDFLAGS="-L$(brew --prefix openssl)/lib"
fi
if command -v cargo 1>/dev/null 2>&1; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi
if command -v npm 1>/dev/null 2>&1; then
  export npm_config_prefix=~/.node_modules
  export PATH="$npm_config_prefix/bin:$PATH"
fi
if command -v python2 1>/dev/null 2>&1; then
  export PATH="$(python2 -m site --user-base)/bin:$(python2 -m site --user-site):$PATH"
fi
if command -v python3 1>/dev/null 2>&1; then
  export PATH="$(python3 -m site --user-base)/bin:$(python3 -m site --user-site):$PATH"
fi


unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

# ====
# WORK
# ====
export AWS_SDK_CPP_DIR="~/lib/aws-sdk-cpp/bin"
export PATH="~/dev/sample/build/bin/:$PATH"

# ===
# MAC
# ===
ulimit -n 32768
# export AWS_SDK_CPP_DIR="/usr/local/lib"

eval $(docker-machine env default)
