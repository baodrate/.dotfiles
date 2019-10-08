[ -r "~/.profile" ] && . "~/.profile"

# if zsh command exits
if hash zsh ; then
  # if in interactive session
  case "$-" in
    *i*)
      # if not a nested in a zsh session
      if [ ! -n "$ZSH_VERSION" ]; then
        zsh
      fi
    ;;
  esac
fi
