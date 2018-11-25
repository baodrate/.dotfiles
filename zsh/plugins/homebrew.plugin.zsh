# https://github.com/sorin-ionescu/prezto/blob/master/modules/homebrew/init.zsh

function echoerr {
  RED='\033[0;31m'
  NC='\033[0m' # No Color
  printf "${RED}$1${NC}\n" 1>&2
  # printf "$1\n" 1>&2
}

# Return if requirements are not found.
if [[ "$OSTYPE" != darwin* ]]; then
  echoerr "homebrew plugin loaded but not running MacOS (OSTYPE = $OSTYPE)"
  return 1
fi

if (( ! $+commands[brew] )); then
  echoerr '`brew` not found; install homebrew with:'
  echo '/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"' >&2
  return 1
fi

#
# Variables
#

# Load standard Homebrew shellenv into the shell session.
# `brew shellenv` is relatively new, guard for legacy Homebrew.
eval "$(brew shellenv 2> /dev/null)"

