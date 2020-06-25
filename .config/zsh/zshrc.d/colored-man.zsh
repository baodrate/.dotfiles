#!/bin/zsh

#    Black Red Green Yellow Blue Magenta Cyan White
# FG    30  31    32     33   34      35   36    37
# BG    40  41    42     43   44      45   46    47

# https://unix.stackexchange.com/questions/108699/documentation-on-less-termcap-variables
# termcap terminfo  
# ks      smkx      make the keypad send commands
# ke      rmkx      make the keypad send digits
# vb      flash     emit visual bell
# mb      blink     start blink
# md      bold      start bold
# me      sgr0      turn off bold, blink and underline
# so      smso      start standout (reverse video)
# se      rmso      stop standout
# us      smul      start underline
# ue      rmul      stop underline

alias man="LESS_TERMCAP_mb=$'\e[01;32m' \
LESS_TERMCAP_md=$'\e[01;36m' \
LESS_TERMCAP_me=$'\e[0m' \
LESS_TERMCAP_so=$'\e[01;44;33m' \
LESS_TERMCAP_se=$'\e[0m' \
LESS_TERMCAP_us=$'\e[04;32m' \
LESS_TERMCAP_ue=$'\e[0m' \
man"
