# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
alias ls='ls -la'
alias cl='clear'
alias uu='sudo xbps-install -Su'
alias qry='xbps-query -Rs'
alias qryi='xbps-query -l'
alias inst='sudo xbps-install -Su'
alias uninst='sudo xbps-remove'

eval "$(starship init bash)"
