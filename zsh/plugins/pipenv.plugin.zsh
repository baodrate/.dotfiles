# https://github.com/pypa/pipenv#shell-completion

# https://github.com/owenstranathan/pipenv.zsh
# https://github.com/piotr-wasilewski/zsh-pipenv

# https://github.com/pypa/pipenv/issues/1247

# Called by zsh when directory changes, append to chpwd_functions
zsh-pipenv-shell-activate() {
  if (( ! $+commands[pipenv] )); then
    echo "Install http://docs.pipenv.org/en/latest/ to use this plugin." > /dev/stderr
    return 1
  fi

  if [ -e "$(pwd)/Pipfile" ]; then
    if [ ! "$PIPENV_ACTIVE" ] && [[ "${VIRTUAL_ENV}" != $(pipenv --venv) ]]; then
      echo -n "Pipfile exists. Do you want spawn a shell with the virtualenv? (y)"
      read answer
      if [[ "$answer" == "y" ]]; then
          cat Pipfile | grep python_version
          pipenv shell --fancy
      fi
    fi
  fi
}

# Add activate to change pwd functions
chpwd_functions+=(zsh-pipenv-shell-activate)

#compdef pipenv
_pipenv() {
  eval $(env COMMANDLINE="${words[1,$CURRENT]}" _PIPENV_COMPLETE=complete-zsh  pipenv)
}
if [[ "$(basename -- ${(%):-%x})" != "_pipenv" ]]; then
  autoload -U compinit && compinit
  compdef _pipenv pipenv
fi
