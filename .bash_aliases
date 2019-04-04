alias l1='ls -1F'  # list-one
alias ll='ls -alF'
alias la='ls -AF'
alias l='ls -CF'

alias g=git
# add git completion to alias
if [[ -r ~/.git-completion.bash ]]; then
  . ~/.git-completion.bash
  __git_complete g __git_main
fi

alias c=clip

# an online snake game
alias tron="ssh sshtron.zachlatta.com"

[ -r ~/.bash_aliases.local ] && . ~/.bash_aliases.local
