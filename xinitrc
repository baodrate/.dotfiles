#!/bin/sh

# Make sure this is before the 'exec' command or it won't be sourced.
[ -f ~/.xprofile ] && source ~/.xprofile

xrandr --output DVI-D-0 --auto --output HDMI-A-0 --auto --right-of DVI-D-0
# xrandr --output DVI-D-0 --off --output HDMI-A-0 --auto --right-of DVI-D-0

pidof -x $(basename urxvtd) || urxvtd -q -o -f
# pidof -x $(basename udiskie) || udiskie --tray --use-udisks2 &
# pidof -x $(basename mako) || mako & # wayland notification daemon
pidof -x $(basename ibus-daemon) || ibus-daemon --xim &
# ibus-daemon --xim &
# compton -b -c
exec i3 -d all 2>&1 > ~/tmp/i3.log
