#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

HISTSIZE=0

source /home/admin/.config/broot/launcher/bash/br

export EDITOR="nvim"
export visual="nvim"
