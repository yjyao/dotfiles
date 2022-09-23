# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return;;
esac

# # Uncomment the following to enable profiling.
# # Note that the results only helps with locating the bottlenecks,
# # but don't reflect the real time.
# # This is because the I/O overhead is bigger than the executions themselves.
# PS4='+ $(date "+%s.%N")\011 '
# exec 5> /tmp/bashstart.$$.log
# BASH_XTRACEFD=5  # requires bash 4.1+
# set -x

# # Uncomment the following to print just a startup time.
# _bashrcloadstartts="$(date "+%s.%N")"

# Toggles for custom behavior.
# Non-empty values enable a flag.
# Below is the default settings. DO NOT MODIFY.
# You can change the default behavior in ~/.profile.d/bash-defaults.sh. E.g.,
#     START_BASH_IN_TMUX=true
#     START_BASH_IN_TMUX=false  # anything non-empty string other than 'true'
: ${START_BASH_IN_TMUX:=false}
: ${HISTFILE_PER_SESSION:=true}  # Overrides `HISTFILE_PER_TMUX_PANE`.
: ${HISTFILE_PER_TMUX_PANE:=true}
: ${LOAD_EXTRA_HISTFILES:=true}

# append to the history file, don't overwrite it
shopt -s histappend

export EDITOR=vim

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
# Set them to unlimited
export HISTSIZE=
export HISTFILESIZE=

# ignore duplicate commands and commands starting with spaces
export HISTCONTROL="ignoreboth:$HISTCONTROL"

# do not store certain common commands and simple 1-2 char commans in history
# also ignore commands starting with whitespaces
HISTIGNORE="?:??:history:history :history -[naw]:history -d*:[[:space:]]*"

HISTTIMEFORMAT='%F %T '

if [[ $HISTFILE_PER_TMUX_PANE = true && -n $TMUX_PANE ]]; then
  # keep a separate history for each tmux pane
  # unset `HISTFILE_PER_TMUX_PANE` to use the default ~/.bash_history
  mkdir -p "$HOME/.bash_histories"
  tmux_pane_name_file="$(mktemp)"
  tmux display-message -p '#{session_name}.#{window_index}.#{pane_index}' > "$tmux_pane_name_file"
  HISTFILE="$HOME/.bash_histories/tmux-$(<"$tmux_pane_name_file").bash_history"
  rm "$tmux_pane_name_file"
elif [[ $HISTFILE_PER_SESSION = true ]]; then
  # keep a separate history for each shell session
  # unset `HISTFILE_PER_SESSION` to use the default ~/.bash_history
  mkdir -p "$HOME/.bash_histories"
  timestamp="$(date +'%Y%m%dT%H%M%S.%3N')"
  HISTFILE="$HOME/.bash_histories/$timestamp.bash_history"
fi

# load all histories to current session.
# unset `LOAD_EXTRA_HISTFILES` to keep the histories to each session.
# use this together with `HISTFILE_PER_SESSION` or `HISTFILE_PER_TMUX_PANE` to
# prevent history loss when exiting multiple sessions at once.
if [[ $BASHRC_ALREADY_LOADED != true && $LOAD_EXTRA_HISTFILES = true ]]; then
  for f in ~/.bash_history ~/.bash_histories/*.bash_history; do
    history -r "$f"
  done
fi

export EDITOR=vim

# Default configs for the `bc` calculator
[ -r ~/.bc ] && export BC_ENV_ARGS=~/.bc

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

# enable git completion features.
if [ -f /etc/bash_completion.d/git ]; then
  . /etc/bash_completion.d/git
elif [ -f /usr/share/bash-completion/completions/git ]; then
  . /usr/share/bash-completion/completions/git
elif [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

if ! command -v __git_ps1 &> /dev/null; then
  __git_ps1() {
    [ -d .git ] && git symbolic-ref --short HEAD
  }
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color|*-256color) color_prompt=yes;;
esac

_PS1='${debian_chroot:+($debian_chroot)}'
_PS1+='\n'
_PS1+='\[\033[96m\]\u@\h\[\033[0m\]'
_PS1+=':'
_PS1+='\[\033[96m\]\w\[\033[0m\]'
_PS1+='\n'
_PS1+='\[\033[32m\]$(__git_ps1 "[%s] ")\[\033[0m\]'
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

# disable Ctrl+S that freezes screen
stty -ixon

# make Ctrl+w deletion recognize path levels
stty werase undef
bind '\C-w:backward-kill-word'
bind '"\e[3;5~":unix-word-rubout'  # Ctrl+Del to backward kill WORD

# Automatically enter tmux.
if [[ $START_BASH_IN_TMUX = true ]]; then
  # Prerequisites:
  # - tmux exists on the system
  # - we're in an interactive shell, and
  # - we're not already in tmux.
  if command -v tmux &> /dev/null && [[ "$-" =~ i ]] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
    exec tmux new -A -s default
  fi
fi

export _Z_DATA=~/.z.data
[ -f ~/.z/z.sh ] && source ~/.z/z.sh  # https://github.com/rupa/z

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

# Sets the date-time format of `ls`.
export TIME_STYLE=long-iso

LESS_VERSION="$(less --version | head -n1 | cut -d ' ' -f2)"

LESS=
LESS+='R'  # control chars (color, etc.)
# auto exit if short
# older `less` needs the 'X' option to prevent screen clearing after exits.
(( LESS_VERSION < 530 )) && LESS+='X'
LESS+='F'
LESS+='i'  # ignore case search
LESS+='q'  # disable bells with excessive scrolling.
export LESS
# seach result highlight style
export LESS_TERMCAP_so=$'\e[30;43m'
export LESS_TERMCAP_se=$'\e[0m'

# todo/task manager. requires https://github.com/todotxt/todo.txt-cli.
export TODOTXT_DEFAULT_ACTION=ls

# https://github.com/yjyao/recap.
export RECAP_HIDDEN=1

[ -f ~/.cargo/env ] && source ~/.cargo/env

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# hotkeys
if [ $BASH_VERSINFO -gt 3 ]; then
  # wraps a function "f" to plug the result of "f" in to where the cursor is at
  _select_widget() {
    local selected="$(eval "$1")"
    _replace_readline '' "$selected"
  }

  _replace_readline() {
    local before="${1?}" after="${2?}"
    READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT-${#before}}${after}${READLINE_LINE:$READLINE_POINT}"
    READLINE_POINT=$(( READLINE_POINT - ${#before} + ${#after} ))
  }

  # NOTE: this gets the word up until the cursor
  _get_readline_word_before_cursor() {
    local word="${READLINE_LINE:0:$READLINE_POINT}"
    word="${word##* }"
    echo "$word"
  }

  # windows -> linux paths
  if command -v wslpath &>/dev/null; then
    _wslpath_cursor_word() {
      local path_orig="$(_get_readline_word_before_cursor)"
      _replace_readline "$path_orig" "$(wslpath "$path_orig")"
    }
    bind -x '"\C-x\C-w": _wslpath_cursor_word'
  fi

  # selections
  if command -v fzf &>/dev/null; then
    # select from results of the last command
    _prev_output_selector() {
      fc -s 2>/dev/null | fzf -1
    }
    bind -x '"\C-x\C-p":"_select_widget _prev_output_selector"'

    # select todo items
    command -v todo-txt &>/dev/null && todo_cmd=todo-txt
    command -v todo.sh &>/dev/null && todo_cmd=todo.sh
    if [ -n $todo_cmd ]; then
      _todo_item_selector() {
        $todo_cmd |
          grep -v '^-*$' | grep -v '^TODO:.*shown' |
          fzf --query '!@maybe !@blocked ' -0 -1 --multi | awk '{print $1}'
      }
      bind -x '"\C-x\C-t":"_select_widget _todo_item_selector"'
    fi
  fi

  # ctrl+alt+e expands all variables on the current line.
fi

# Source extra configs.
for f in ~/.bash/{configs,functions,aliases,completion}/*.sh; do
  [ -r "$f" ] && . "$f"
done

# Adding wsl-open as a browser for Bash for Windows
if [[ $(uname -r) =~ (m|M)icrosoft ]] &&
  command -v wsl-open &>/dev/null &&
  [[ $BROWSER != *wsl-open* ]]; then
  export BROWSER=${BROWSER:+${BROWSER}:}wsl-open
fi

set +x

export BASHRC_ALREADY_LOADED=true

[[ ${_bashrcloadstartts} ]] && echo bash startup time: $(bc <<< "$(date "+%s.%N") - ${_bashrcloadstartts}")

:  # Normal exit.
