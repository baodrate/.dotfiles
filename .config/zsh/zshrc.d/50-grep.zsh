#!/bin/zsh

typeset -ga grep_options

# Color on GNU and FreeBSD grep(1)
if grep --color=auto -q "a" <<< "a" >/dev/null 2>&1; then
    grep_options+=( --color=auto )
fi

alias grep="command grep ${grep_options:+${grep_options[*]}}"

unset grep_options
