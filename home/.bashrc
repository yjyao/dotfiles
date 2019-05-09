# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return;;
esac

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
# Set them to unlimited
export HISTSIZE=
export HISTFILESIZE=

# ignore duplicate commands and commands starting with spaces
export HISTCONTROL="ignoreboth:$HISTCONTROL"

# do not store certain common commands and simple 1-2 char commans in history
# also ignore commands starting with whitespaces
HISTIGNORE="?:??:history:[[:space:]]*"

HISTTIMEFORMAT='%F %T '

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color|*-256color) color_prompt=yes;;
esac

PROMPT_COMMAND+='_GITBRANCH=$(git brcurr 2> /dev/null);'

_PS1='${debian_chroot:+($debian_chroot)}'
_PS1+='\n'
_PS1+='\[\033[96m\]\u@\h\[\033[0m\]'
_PS1+=':'
_PS1+='\[\033[96m\]\w\[\033[0m\]'
_PS1+='\n'
_PS1+='\[\033[32m\]$([[ $_GITBRANCH ]] && echo "[$_GITBRANCH] ")\[\033[0m\]'
_PS1+='\$ '
_PS1+='\[\033[0:0m\]'
PS1=$_PS1

unset color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  [ -r ~/.dircolors ] && eval "$(dircolors -b ~/.dircolors)" \
    || ( [ -r ~/.dir_colors/dircolors ] && eval "$(dircolors ~/.dir_colors/dircolors)" ) \
    || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# import aliases
[ -r ~/.bash_aliases ] && . ~/.bash_aliases

# disable Ctrl+S that freezes screen
stty -ixon

# make Ctrl+w deletion recognize path levels
stty werase undef
bind '\C-w:unix-filename-rubout'

# initialize https://github.com/nvbn/thefuck
if command -v thefuck &> /dev/null; then
  eval $(thefuck --alias)
fi

# # Automatically enter tmux if
# # 1) tmux exists on the system
# # 2) we're in an interactive shell, and
# # 3) tmux doesn't try to run within itself:
# if command -v tmux &> /dev/null && [[ "$-" =~ i ]] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#   exec tmux
# fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Add extra fzf complete supports
if command -v _fzf_dir_completion &> /dev/null; then
  complete -F _fzf_dir_completion -o default -o bashdefault tree
fi

export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --ansi'
if command -v fd &> /dev/null; then
  export FZF_DEFAULT_COMMAND='fd --follow --hidden --exclude ".git" --color=auto'
  export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type directory"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND --type --type file"
fi

export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

LESSVERSION="$(less -V | head -1 | cut -d' ' -f2)"

LESS=
LESS+='R'  # control chars (color, etc.)
# auto exit if short
# for older `less`, 'X' needs to be added to prevent screen clearing after exits
[[ $LESSVERSION -gt 530 ]] && LESS+='F' || LESS+='XF'
LESS+='i'  # ignore case search
export LESS=$LESS

[ -r ~/.bashrc.local ] && . ~/.bashrc.local
