#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -l'
alias l='ls'

alias vi='nvim'
export EDITOR=nvim

PS1='[\u@\h \W]\$ '

export PATH=$PATH:$HOME/.local/bin
export npm_config_prefix="$HOME/.local"
