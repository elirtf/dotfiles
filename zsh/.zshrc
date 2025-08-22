# .zshrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

PS1='[\u@\h \W]\$ '
alias ls='ls -la'
alias c='clear'
alias uu='sudo xbps-install -Su'
alias qry='xbps-query -Rs'
alias qryi='xbps-query -l'
alias inst='sudo xbps-install -Su'
alias uninst='sudo xbps-remove'

# Get local IP addresses (alias)
if [[ -x "$(command -v ip)" ]]; then
	alias iplocal="ip -br -c a"
else
	alias iplocal="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
fi

# Get public IP addresses (alias)
if [[ -x "$(command -v curl)" ]]; then
	alias ipexternal="curl -s ifconfig.me && echo"
elif [[ -x "$(command -v wget)" ]]; then
	alias ipexternal="wget -q0- ifconfig.me && echo"
fi


eval "$(starship init zsh)"

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

source ~/.config/zsh/zsh-syntax-highlightin-tokyonight.zsh


