#!/bin/zsh

autoload -Uz compinit
compinit

setopt autocd
setopt notify

# bracketed-paste
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

# Use smart URL pasting and escaping.
autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic

GPG_TTY=$(tty)

scripts=(${${(%):-%x}:h}/zshrc.d/*(Nn))
plugins=("${XDG_DATA_HOME:-$HOME/.local/share}"/zsh/plugins/*/*.plugin.zsh(Nn))

for script in ${scripts[@]} ${plugins[@]} ; do
  source "$script"
done
