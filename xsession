#!/usr/bin/env bash

[[ -f ~/.Xresources ]] && xrdb -merge -I $HOME ~/.Xresources

xsetroot -cursor_name left_ptr

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

fcitx5 &

xbindkeys

# [[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

sleep 1

exec xmonad
