HISTSIZE=1048576
HISTFILE="$HOME/.bash_history"
shopt -s histappend # append to history file
shopt -s checkwinsize # update console size
shopt -s globstar # use **

# enable color support of ls and greps
eval "$(dircolors -b)"
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

export EDITOR=code
