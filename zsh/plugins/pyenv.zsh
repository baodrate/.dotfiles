if (( $+commands[pyenv] )); then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi
