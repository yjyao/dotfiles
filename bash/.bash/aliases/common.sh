# File listing.
alias l='ls -vCF'
alias l1='l -1'  # list-one
alias ll='l -lAh'
alias la='l -A'

# Going up in directories.
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Pushing/popping directories.
alias pu=pushd
alias po=popd

alias :e=vim
alias c=clip
alias e=less

alias gitdiff='git diff --no-index'

# Ignore (downstream) broken pipes.
# Allows `tee | head` for previews.
alias tee='tee --output-error=exit-nopipe'
