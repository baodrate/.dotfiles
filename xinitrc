#!/bin/sh

[ -f ~/.xprofile ] && source ~/.xprofile

xrandr --output DVI-D-0 --auto --output HDMI-A-0 --auto --right-of DVI-D-0
# xrandr --output DVI-D-0 --off --output HDMI-A-0 --auto --right-of DVI-D-0

pidof -s urxvtd || urxvtd -q -o &
pidof -s dunst || dunst &
pidof -s compton || compton -b
pidof -s -x udiskie || udiskie &
pidof -s -x blueman-applet || blueman-applet &
pidof -s -x lxqt-policykit-agent || lxqt-policykit-agent &

# pidof ibus-daemon || ibus-daemon --xim &

exec i3 -d all >~/.local/share/i3.out.log 2>~/.local/share/i3.err.log
# export GDK_BACKEND=x11
# exec gnome-session
