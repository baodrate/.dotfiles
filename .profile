# gpgconf --launch gpg-agent

# export SSH_AUTH_SOCKET=$HOME/.gnupg/S.gpg-agent.ssh
# export SSH_AUTH_SOCK=$HOME/.gnupg/S.gpg-agent.ssh

command -v foo >/dev/null 2>&1 && {
  if [ -f $(brew --prefix)/etc/brew-wrap ];then
    source $(brew --prefix)/etc/brew-wrap
  fi
}
