#!/bin/sh

# Make sure this is before the 'exec' command or it won't be sourced.
[ -f ~/.xprofile ] && source ~/.xprofile

pidof -x $(basename urxvtd) || urxvtd -q -o -f
pidof -x $(basename udiskie) || udiskie &
pidof -x $(basename mako) || mako &
pidof -x $(basename ibus-daemon) || ibus-daemon --xim &
xrdb ~/.Xresources
# ibus-daemon --xim &
compton -b -c
exec i3 -d all 2>&1 > ~/tmp/i3.log
