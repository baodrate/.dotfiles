#!/bin/zsh

zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' menu select=2
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*' squeeze-slashes true
zstyle :compinstall filename '/home/bao/.zshrc'

autoload -Uz compinit
compinit

# TODO: avoid FS access?
[ ! -d "${XDG_DATA_HOME:-$HOME/.local/share}"/zsh ] && mkdir -p "${XDG_DATA_HOME:-$HOME/.local/share}"/zsh

setopt autocd
setopt notify

# bracketed-paste
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

# Use smart URL pasting and escaping.
autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic

# enable 'inner' vi-motions e.g. ci(
autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $m $c select-bracketed
  done
done

bindkey -v
bindkey '^R' history-incremental-pattern-search-backward

GPG_TTY=$(tty)

ssht() {
  ssh -t $@ "sh -c 'tmux a || tmux'"
}

if [ -d ${${(%):-%x}:h}/zshrc.d ]; then
  for file in ${${(%):-%x}:h}/zshrc.d/*; do
    source "$file"
  done
fi

for file in "${XDG_DATA_HOME:-$HOME/.local/share}"/zsh/plugins/*/*.plugin.zsh ; do
  source "$file"
done
