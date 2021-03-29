alias l1='ls -1F'  # list-one
alias ll='ls -FlAsh'
alias la='ls -AF'
alias l='ls -CF'

alias g=git
# add git completion to alias
if [[ -r /usr/share/bash-completion/completions/git ]]; then
  . /usr/share/bash-completion/completions/git
elif [[ -r ~/.git-completion.bash ]]; then
  . ~/.git-completion.bash
fi
if command -v __git_complete &> /dev/null; then
  __git_complete g __git_main
fi

md5() { md5sum "$@" | awk '{ print $1 }'; }
alias e=less
alias :e=vim
alias c=clip
alias watch="watch --color"
alias histdel='history -n && history -d "$(history|tac|fzf -e|awk "{print \$1}")" && history -w'
alias jsonprint='python -m json.tool'
command -v fdfind &>/dev/null && ! command -v fd &>/dev/null && alias fd=fdfind
alias tg='telegram-cli -l1 -NAW'
alias recap='recap -d "5 hours ago"'

# an online snake game
alias tron="ssh sshtron.zachlatta.com"

# *** um: personal man pages ***
export MANPATH="$MANPATH:$HOME/.man"
# # Uncomment the following to add the `jy` section to man.
# # I.e., use it like `man jy grep`.
# # However, this requires a clever way to get the default $MANSECT which may
# # vary from system to system. You can manually check it with 
# # $ cat /etc/man*.{config,conf} 2>/dev/null | grep "^SECTION" || man man | grep $MANSECT
# DEFAULT_MANSECT="1:n:l:8:3:2:3posix:3pm:3perl:3am:5:4:9:6:7"
# export MANSECT="${MANSECT:-$DEFAULT_MANSECT}:jy"
alias um='man -S jy'
umedit() {
  if [ ! -d "$HOME/.man/manjy" ]; then
    >&2 echo "FATAL: missing required directory $HOME/.man/manjy"
    return 1
  fi
  if [ -n "$1" ]; then
    vim "$HOME/.man/manjy/$1.jy"
  else
    >&2 echo "USAGE: $FUNCNAME PAGE"
    return 1
  fi
}

# todo/task manager. requires https://github.com/todotxt/todo.txt-cli.
if command -v todo.sh &>/dev/null; then
  alias t=todo.sh
  if [ -f /usr/local/share/bash_completion.d/todo ]; then
    . /usr/local/share/bash_completion.d/todo
  fi
elif command -v todo-txt &>/dev/null; then
  alias t=todo-txt
  if [ -f /usr/share/bash-completion/completions/todo-txt ]; then
    . /usr/share/bash-completion/completions/todo-txt
  fi
fi
if command -v _todo &>/dev/null; then
  complete -F _todo t
fi

[ -r ~/.bash_aliases.local ] && . ~/.bash_aliases.local
