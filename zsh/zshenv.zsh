export SHELL="zsh"

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export NVIM_LISTEN_ADDRESS=$HOME/tmp/nvimsocket

# fix for https://github.com/swaywm/sway/issues/595
export _JAVA_AWT_WM_NONREPARENTING=1

if (( ! ${+XDG_CONFIG_HOME} )); then
  XDG_CONFIG_HOME="~/.config"
fi

# ==> setup default editor
if (( $+commands[nvim] )) ; then
  export VISUAL=nvim
  export NVIM_TUI_ENABLE_TRUE_COLOR=1
elif (( $+commands[vim] )) ; then
  export VISUAL=vim
else
  echo 'could not find neovim or vim; not setting $VISUAL'
fi

# ==> Setup PATH env variable
PATH="$(getconf PATH)"

[[ -d "$HOME/.scripts" ]] && PATH="$HOME/.scripts:$PATH"
[[ -d "$HOME/.cargo/bin" ]] && PATH="$HOME/.cargo/bin:$PATH"
[[ -d "/usr/local/bin" ]] && PATH="/usr/local/bin:$PATH"
[[ -d "/usr/local/sbin" ]] && PATH="/usr/local/sbin:$PATH"
[[ -d "/usr/local/opt/ccache/libexec" ]] && PATH="/usr/local/opt/ccache/libexec:$PATH"
(( $+commands[python2] )) && PATH="$(python2 -m site --user-base)/bin:$(python2 -m site --user-site):$PATH"
(( $+commands[python3] )) && PATH="$(python3 -m site --user-base)/bin:$(python3 -m site --user-site):$PATH"
(( $+commands[npm] )) && export npm_config_prefix=~/.node_modules && PATH="$npm_config_prefix/bin:$PATH"

export PATH=$PATH


# ==> use gpg-agent as ssh-agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

# workaround for issue with qtwebengine + opengl + nouveau
# see https://bugs.archlinux.org/task/59057
QT_XCB_FORCE_SOFTWARE_OPENGL=1

# ====
# WORK
# ====
export AWS_SDK_CPP_DIR="~/aws-sdk-cpp/"


# ===
# MAC
# ===
# ulimit -n 32768
