#!/bin/zsh

# 10ms for key sequences (<ESC>)
KEYTIMEOUT=0

# Use vi-like key bindings by default:
bindkey -v

# Load a few more functions and tie them to widgets, so they can be bound:

function zrcautozle () {
    emulate -L zsh
    local fnc=$1
    autoload $fnc && zle -N $fnc
}

function zrcgotwidget () {
    (( ${+widgets[$1]} ))
}

function zrcgotkeymap () {
    [[ -n ${(M)keymaps:#$1} ]]
}

function zrcbindkey () {
    if (( ARGC )) && zrcgotwidget ${argv[-1]}; then
        bindkey "$@"
    fi
}

## beginning-of-line OR beginning-of-buffer OR beginning of history
## by: Bart Schaefer <schaefer@brasslantern.com>, Bernhard Tittelbach
function beginning-or-end-of-somewhere () {
    local hno=$HISTNO
    if [[ ( "${LBUFFER[-1]}" == $'\n' && "${WIDGET}" == beginning-of* ) || \
      ( "${RBUFFER[1]}" == $'\n' && "${WIDGET}" == end-of* ) ]]; then
        zle .${WIDGET:s/somewhere/buffer-or-history/} "$@"
    else
        zle .${WIDGET:s/somewhere/line-hist/} "$@"
        if (( HISTNO != hno )); then
            zle .${WIDGET:s/somewhere/buffer-or-history/} "$@"
        fi
    fi
}

zle -N beginning-of-somewhere beginning-or-end-of-somewhere
zle -N end-of-somewhere beginning-or-end-of-somewhere

function bind2maps () {
    local i sequence widget
    local -a maps

    while [[ "$1" != "--" ]]; do
        maps+=( "$1" )
        shift
    done
    shift

    if [[ "$1" == "-s" ]]; then
        shift
        sequence="$1"
    else
        sequence="${key[$1]}"
    fi
    widget="$2"

    [[ -z "$sequence" ]] && return 1

    for i in "${maps[@]}"; do
        zrcbindkey -M "$i" "$sequence" "$widget"
    done
}

typeset -A key
key=(
    Home     "${terminfo[khome]}"
    End      "${terminfo[kend]}"
    Insert   "${terminfo[kich1]}"
    Delete   "${terminfo[kdch1]}"
    Up       "${terminfo[kcuu1]}"
    Down     "${terminfo[kcud1]}"
    Left     "${terminfo[kcub1]}"
    Right    "${terminfo[kcuf1]}"
    PageUp   "${terminfo[kpp]}"
    PageDown "${terminfo[knp]}"
    BackTab  "${terminfo[kcbt]}"
)

# Guidelines for adding key bindings:
#
#   - Do not add hardcoded escape sequences, to enable non standard key
#     combinations such as Ctrl-Meta-Left-Cursor. They are not easily portable.
#
#   - Adding Ctrl characters, such as '^b' is okay; note that '^b' and '^B' are
#     the same key.
#
#   - All keys from the $key[] mapping are obviously okay.
#
#   - Most terminals send "ESC x" when Meta-x is pressed. Thus, sequences like
#     '\ex' are allowed in here as well.

zrcautozle insert-files
zrcautozle edit-command-line
if autoload history-search-end; then
    zle -N history-beginning-search-backward-end history-search-end
    zle -N history-beginning-search-forward-end  history-search-end
fi
zle -C hist-complete complete-word _generic
zstyle ':completion:hist-complete:*' completer _history

bind2maps emacs             -- Home     beginning-of-somewhere
bind2maps       viins vicmd -- Home     vi-beginning-of-line
bind2maps emacs             -- End      end-of-somewhere
bind2maps       viins vicmd -- End      vi-end-of-line
bind2maps emacs viins       -- Insert   overwrite-mode
bind2maps             vicmd -- Insert   vi-insert
bind2maps emacs             -- Delete   delete-char
bind2maps       viins vicmd -- Delete   vi-delete-char
bind2maps emacs viins vicmd -- Up       up-line-or-search
bind2maps emacs viins vicmd -- Down     down-line-or-search
bind2maps emacs viins vicmd -- -s '^P'  vi-up-line-or-history
bind2maps emacs viins vicmd -- -s '^N'  vi-down-line-or-history
bind2maps emacs             -- Left     backward-char
bind2maps       viins vicmd -- Left     vi-backward-char
bind2maps emacs             -- Right    forward-char
bind2maps       viins vicmd -- Right    vi-forward-char
# search history backward for entry beginning with typed text
bind2maps emacs viins       -- PageUp   history-beginning-search-backward-end
# search history forward for entry beginning with typed text
bind2maps emacs viins       -- PageDown history-beginning-search-forward-end
# Search backwards and forwards with a pattern
bind2maps             vicmd -- '/'      history-incremental-pattern-search-backward
bind2maps             vicmd -- '?'      history-incremental-pattern-search-forward
# set up for insert mode too
bind2maps emacs viins vicmd -- -s '^R'  history-incremental-pattern-search-backward
bind2maps emacs viins vicmd -- -s '^S'  history-incremental-pattern-search-forward
# Do history expansion on space:
bind2maps emacs viins       -- -s ' ' magic-space

if zrcgotkeymap menuselect; then
    #m# k Shift-tab Perform backwards menu completion
    bind2maps menuselect -- BackTab reverse-menu-complete

    #k# menu selection: pick item but stay in the menu
    bind2maps menuselect -- -s '\e^M' accept-and-menu-complete
    # also use + and INSERT since it's easier to press repeatedly
    bind2maps menuselect -- -s '+' accept-and-menu-complete
    bind2maps menuselect -- Insert accept-and-menu-complete

    # accept a completion and try to complete again by using menu
    # completion; very useful with completing directories
    # by using 'undo' one's got a simple file browser
    bind2maps menuselect -- -s '^o' accept-and-infer-next-history
fi

# enable 'inner' vi-motions e.g. ci(
autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $m $c select-bracketed
  done
done

# Finally, here are still a few hardcoded escape sequences; Special sequences
# like Ctrl-<Cursor-key> etc do suck a fair bit, because they are not
# standardised and most of the time are not available in a terminals terminfo
# entry.
#
# While we do not encourage adding bindings like these, we will keep these for
# backward compatibility.

## use Ctrl-left-arrow and Ctrl-right-arrow for jumping to word-beginnings on
## the command line.
# URxvt sequences:
bind2maps emacs viins vicmd -- -s '\eOc' forward-word
bind2maps emacs viins vicmd -- -s '\eOd' backward-word
# These are for xterm:
bind2maps emacs viins vicmd -- -s '\e[1;5C' forward-word
bind2maps emacs viins vicmd -- -s '\e[1;5D' backward-word
## the same for alt-left-arrow and alt-right-arrow
# URxvt again:
bind2maps emacs viins vicmd -- -s '\e\e[C' forward-word
bind2maps emacs viins vicmd -- -s '\e\e[D' backward-word
# Xterm again:
bind2maps emacs viins vicmd -- -s '^[[1;3C' forward-word
bind2maps emacs viins vicmd -- -s '^[[1;3D' backward-word
# Also try ESC Left/Right:
bind2maps emacs viins vicmd -- -s '\e'${key[Right]} forward-word
bind2maps emacs viins vicmd -- -s '\e'${key[Left]}  backward-word

unset key

unfunction bind2maps zrcautozle zrcgotwidget zrcgotkeymap
