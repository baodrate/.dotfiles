export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH="$HOME/.scripts:/usr/local/bin/:/usr/local/sbin:$(getconf PATH)"
export SHELL="zsh"

if (( $+commands[nvim] )) ; then
  export EDITOR=nvim
  export NVIM_TUI_ENABLE_TRUE_COLOR=1
else
  if (( $+commands[vim] )) ; then
    export EDITOR=vim
  else
    export EDITOR=nano
  fi
fi
