#!/usr/bin/env bash

[ -r "/etc/bashrc" ] && source "/etc/bashrc"
[ -r "/etc/bash.bashrc" ] && source "/etc/bash.bashrc"

[ -r ~/.env ] && source ~/.env

# ==============================================================================
# ==> INTERACTIVE
# ==============================================================================
# Settings below only apply to interactive sessions

[[ $- != *i* ]] && return

# if zsh exists and not in a nested ZSH session
if hash zsh 2>/dev/null && [ -n "$ZSH_VERSION" ]; then
  zsh
fi

# ---
# PS1
# ---
_PROMPT() {
  local _EXIT_STATUS=$?

  # credit: http://dotshare.it/dots/32/

  local -r bold="\e[1m"
  local -r _bold="\e[21m"
  local -r dim="\e[2m"
  local -r _dim="\e[22m"

  local -r reset="\e[0m"

  local -r blue="\e[34m"
  local -r yellow="\e[33m"
  local -r light_grey="\e[37m"
  local -r white="\e[0m"
  local -r red="\e[31m"

  local -r _PROMPT_SYM=" ${bold}${blue}»${reset} "
  local -r _PRE_PROMPT="${dim}${light_grey}${reset}» "

  local -r _HOSTNAME_STR="${yellow}\h${reset}"
  local -r _PATH_STR="${light_grey}$dim[${reset}${white}\w${light_grey}${dim}]${reset}"

  [ $_EXIT_STATUS != 0 ] && local _EXIT_STATUS_STR="${red}[${bold}${_EXIT_STATUS}${_bold}]${reset}"

  PS1="${_PRE_PROMPT}${_HOSTNAME_STR}╺─╸${_PATH_STR}${_EXIT_STATUS_STR}${_PROMPT_SYM}"
}
PROMPT_COMMAND=_PROMPT

# -------
# Aliases
# -------
if [[ ! -z "$LS_COLORS" ]]; then
  export CLICOLOR=1
fi
