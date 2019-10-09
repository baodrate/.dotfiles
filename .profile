#!/bin/sh

# gpgconf --launch gpg-agent

# export SSH_AUTH_SOCKET=$HOME/.gnupg/S.gpg-agent.ssh
# export SSH_AUTH_SOCK=$HOME/.gnupg/S.gpg-agent.ssh

[ -r "$HOME/.env" ] && . "$HOME/.env"

[ -r "/etc/profile" ] && . "/etc/profile"

for file in $HOME/.profile.d/*; do
  echo "found profile.d file: $file"
  if [ -x "$file" ]; then
    . "$file"
  fi
done
