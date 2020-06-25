#!/bin/zsh

declare -a ls_flags
declare -a ll_flags

ll_flags=(
  -l                # long listing
  -h                # human-readable
  --no-group
  --time-style=iso
)

# alias ls="ls $ls_flags"

function _ls {
  ls_flags=(
    --color=auto
    --ignore-backups
  )

  if [ -t 1 ] ; then
    ls_flags+=(
      -F            # classify (indicater chars after name)
    )
  fi

  $commands[ls] $ls_flags $@
}

alias ls="_ls"

alias ll="ls $ll_flags"

unset ls_flags ll_flags
