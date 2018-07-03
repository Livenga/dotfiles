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
export ARM_GCC_ROOT=/opt/gcc-arm-none-eabi-7-2018-q2-update

export PATH=$PATH:$ARM_GCC_ROOT/bin:~/.bin
