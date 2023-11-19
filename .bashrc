# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Prompt customization
if [ -f /etc/bash_completion.d/git-prompt ]; then
    . /etc/bash_completion.d/git-prompt
fi
if [ -f /usr/share/bash-completion/completions/git ]; then
    . /usr/share/bash-completion/completions/git
fi

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto

# first line
PS1='\[\033[32m\]\D{%F_%T} ' # display date and time in green
PS1="$PS1"'\[\033[33m\][\h]:\w' # display hostname and fullpath in yellow
# second line
PS1="$PS1"'\n' # line break
PS1="$PS1"'\[\033[0m\][\u@\W] ' # display user name and current directory in
PS1="$PS1"'\[\033[36m\]$(__git_ps1)' # display git-prompt in blue
PS1="$PS1"'\[\033[0m\]\$ ' # display prompt in default color
