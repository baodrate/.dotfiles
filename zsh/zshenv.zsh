export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export npm_config_prefix=~/.node_modules
export PATH="$HOME/.node_modules/bin:$HOME/.cargo/bin:$(python -m site --user-site):$HOME/.scripts:$(getconf PATH)"
export SHELL="zsh"

if (( $+commands[nvim] )) ; then
  export VISUAL=nvim
  export NVIM_TUI_ENABLE_TRUE_COLOR=1
elif (( $+commands[vim] )) ; then
  export VISUAL=vim
else 
  echo 'could not find neovim or vim; not setting $VISUAL'
fi
