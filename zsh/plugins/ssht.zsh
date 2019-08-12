#!/usr/bin/env zsh

ssht() {
  ssh -t $@ "sh -c 'tmux a || tmux'"
}
compdef ssht=ssh
