# Todo/task manager. requires https://github.com/todotxt/todo.txt-cli.

# See ~/.bash/completion/todo-txt.sh for completion.
if command -v todo.sh &>/dev/null; then
  alias t=todo.sh
elif command -v todo-txt &>/dev/null; then
  alias t=todo-txt
fi
