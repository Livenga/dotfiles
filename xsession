#!/usr/bin/env bash

[[ -f ~/.Xresources ]] && xrdb -merge -I $HOME ~/.Xresources

xsetroot -cursor_name left_ptr


export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

ibus-daemon -drxR

exec xmonad
