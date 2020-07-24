#!/bin/zsh

typeset -ga ls_options

if ls --version |& grep -q 'GNU' >/dev/null 2>&1; then
    ls_options+=(
      --color=auto
      -v                # Natural sorting order of (version) numbers on GNU ls(1)
      --ignore-backups
      --time-style=iso
      -h                # human readable sizes
    )
else
    ls_options+=(
      -G                # Colors on FreeBSD and OSX ls(1)
    )
fi

# TODO
# if [ -t 1 ] ; then
#   ls_options+=(
#     -F                  # classify (indicater chars after name)
#   )
# fi


# do we have GNU ls with color-support?
if [[ "$TERM" != dumb ]]; then
    # List files with colors
    alias ls="command ls ${ls_options:+${ls_options[*]}} $([ -t 1 ])"
    # List all files, with colors
    alias la="command ls -la ${ls_options:+${ls_options[*]}}"
    # List files with long colored list, without dotfiles
    alias ll="command ls -l ${ls_options:+${ls_options[*]}}"
    # List files with long colored list, human readable sizes
    alias lh="command ls -hAl ${ls_options:+${ls_options[*]}}"
    # List files with long colored list, append qualifier to filenames
    alias l="command ls -l ${ls_options:+${ls_options[*]}}"
else
    alias la='command ls -la'
    alias ll='command ls -l'
    alias lh='command ls -hAl'
    alias l='command ls -l'
fi

# listing stuff

# Only show dot-directories
alias lad='command ls -d .*(/)'
# Only show dot-files
alias lsa='command ls -a .*(.)'
# Only files with setgid/setuid/sticky flag
alias lss='command ls -l *(s,S,t)'
# Only show symlinks
alias lsl='command ls -l *(@)'
# Display only executables
alias lsx='command ls -l *(*)'
# Display world-{readable,writable,executable} files
alias lsw='command ls -ld *(R,W,X.^ND/)'
# Display the ten biggest files
alias lsbig="command ls -flh *(.OL[1,10])"
# Only show directories
alias lsd='command ls -d *(/)'
# Only show empty directories
alias lse='command ls -d *(/^F)'
# Display the ten newest files
alias lsnew="command ls -rtlh *(D.om[1,10])"
# Display the ten oldest files
alias lsold="command ls -rtlh *(D.Om[1,10])"
# Display the ten smallest files
alias lssmall="command ls -Srl *(.oL[1,10])"
# Display the ten newest directories and ten newest .directories
alias lsnewdir="command ls -rthdl *(/om[1,10]) .*(D/om[1,10])"
# Display the ten oldest directories and ten oldest .directories
alias lsolddir="command ls -rthdl *(/Om[1,10]) .*(D/Om[1,10])"

unset ls_options
