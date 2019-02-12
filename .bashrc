#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

alias l='ls'
alias la='ls -a'
alias ll='ls -l'

alias vi='vim'
alias dates='date +%Y%m%d'

export LD_LIBRARY_PATH=/usr/local/lib

# Android SDK
export ANDROID_SDK=/opt/android-sdk
export ANDROID_SDK_TOOLS=$ANDROID_SDK/tools
export ANDROID_SDK_PLAFORM_TOOLS=$ANDROID_SDK/platform-tools

export PATH=$PATH:$ANDROID_SDK_TOOLS:$ANDROID_SDK_PLAFORM_TOOLS:~/.bin
