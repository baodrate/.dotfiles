#!/bin/sh

# gpgconf --launch gpg-agent

# export SSH_AUTH_SOCKET=$HOME/.gnupg/S.gpg-agent.ssh
# export SSH_AUTH_SOCK=$HOME/.gnupg/S.gpg-agent.ssh

[ -r "/etc/profile" ] && . "/etc/profile"
[ -r "~/.env" ] && . "~/.env"

for file in $HOME/.profile.d/*; do
  if [ -r "$file" ]; then
    . "$file"
  fi
done
