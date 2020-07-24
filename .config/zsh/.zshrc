#!/bin/zsh

ZPROFILE=
if [ -n "$ZPROFILE" ] ; then
  zmodload zsh/zprof
  # http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
  PS4=$'%D{%M%S%.} %N:%i> '
  exec 3>&2 2>$HOME/startlog.$$
  setopt xtrace prompt_subst
fi

GPG_TTY=$(tty)

scripts=(${${(%):-%x}:h}/zshrc.d/*(Nn))
plugins=(${${(%):-%x}:h}/plugins/*/*.plugin.zsh(Nn))

for script in ${scripts[@]} ${plugins[@]} ; do
  source "$script"
done

if [ -n "$ZPROFILE" ] ; then
  unsetopt xtrace
  exec 2>&3 3>&-
  zprof > ~/zshprofile$(date +'%s')
fi
