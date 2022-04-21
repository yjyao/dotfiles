# Todo/task manager. requires https://github.com/todotxt/todo.txt-cli.

if [ -r /usr/local/share/bash_completion.d/todo ]; then
  . /usr/local/share/bash_completion.d/todo
elif [ -f /usr/share/bash-completion/completions/todo-txt ]; then
  . /usr/share/bash-completion/completions/todo-txt
fi

# See ~/.bash/aliases/todo-txt.sh for alias definition.
if command -v _todo &>/dev/null; then
  complete -F _todo t
fi
