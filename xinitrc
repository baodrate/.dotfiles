#!/bin/sh

# Make sure this is before the 'exec' command or it won't be sourced.
[ -f ~/.xprofile ] && source ~/.xprofile

xrdb ~/.Xresources
# ibus-daemon --xim &
compton -b -c
exec i3 -d all 2>&1 > ~/tmp/i3.log
