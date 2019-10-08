local ls_cmd="ls"
local ls_default_flags=()

# Default i.e. posix flags
local ls_long="-l"
local ls_short=""
local ls_sort_newest="-t"
local ls_hidden=""
local ls_show_hidden="-a"
local ls_one_line="-1"

# platform-specific flags
local ls_colors=""
local ls_indicators=""
local ls_human_filesizes=""
local ls_group_dirs

if (( $+commands[exa] )) ; then
  local exa_grid="--grid"                       # -G show long format in grid (multi-column)
  local exa_git="--git"                         #    list files' git status
  local exa_ext="--extended"                    # -@ show files’ extended attributes and sizes
  local exa_group="--group"                     # -g show files’ group

  ls_short="$exa_grid $ls_long $exa_git"
  ls_long="--long $exa_git $exa_ext $exa_group" # -l show metadata
  ls_sort_newest="--sort=newest"                #    --sort=modified --reverse
  ls_hidden="--git-ignore"                      #    hide files defined in gitignore
  ls_show_hidden="--all"                        # -a (call twice to show . and ..)
  ls_one_line="--oneline"                       # -1
  ls_colors="--color=automatic"                 #    'always' to forward to e.g. less
  ls_indicators="--classify"                    # -F
  ls_human_filesizes="--binary"                 # -b use binary prefixes (e.g. KiB vs KB)
  ls_group_dirs="--group-directories-first"     #    self-explanatory

  ls_default_flags+=($exa_colors $exa_indicators $exa_human_filesizes $exa_group_dirs)
  ls_cmd="exa"

else
  if [[ $OSTYPE = linux* || $OSTYPE = darwin* && (( $+commands[gls] )) ]] ; then
    # macOS but we have `brew coreutils`
    if [[ $OSTYPE = darwin* && (( $+commands[gls] )) ]] ; then
      ls_cmd="gls"
    fi

    ls_short=""
    ls_long="-l"
    ls_sort_newest="-t"
    ls_hidden=""
    ls_show_hidden="-A"
    ls_one_line="-1"
    ls_colors="--color=always"
    ls_indicators="-F"
    ls_human_filesizes="-h"

    ls_group_dirs="--group-directories-first"

  elif [[ $OSTYPE = 'osx' ]]; then
    ls_short=""
    ls_long="-l"
    ls_sort_newest="-t"
    ls_hidden=""
    ls_show_hidden="-A"
    ls_one_line="-1"
    ls_colors="-G"
    ls_indicators="-F"
    ls_human_filesizes="-h"
  fi

fi

ls_default_flags+=($ls_colors $ls_indicators $ls_human_filesizes $ls_group_dirs)
ls_cmd_short="$ls_cmd ${^ls_default_flags} $ls_short"
ls_cmd_long="$ls_cmd ${^ls_default_flags} $ls_long"

alias ls="$ls_cmd ${^ls_default_flags} $ls_hidden"
alias lsa="$ls_cmd ${^ls_default_flags} $ls_show_hidden"

alias l="$ls_cmd_short $ls_hidden"
alias la="$ls_cmd_short $ls_show_hidden"
alias lt="$ls_cmd_short $ls_hidden $ls_sort_newest"
alias lat="$ls_cmd_short $ls_show_hidden $ls_sort_newest"
alias ll="$ls_cmd_long $ls_hidden"
alias lla="$ls_cmd_long $ls_show_hidden"
alias llt="$ls_cmd_long $ls_hidden $ls_sort_newest"
alias llat="$ls_cmd_long $ls_show_hidden $ls_sort_newest"

