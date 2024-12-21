if (( $BASH_VERSINFO < 3 )); then
  >&2 echo 'Skipping hotkey bindings because bash version is too low.'
  exit
fi

# TODO: Move the definition from bashrc here.
if ! (
  command -v _select_widget &&
  command -v _replace_readline &&
  command -v _get_readline_word_before_cursor) &>/dev/null; then
    >&2 echo 'Missing require functions.'
    exit
fi

# Removes file name / gets dirname of the file under cursor.
# WARNING: Overriding <ctrl-d>, which is equivalent to the <delete> key anyway.
__hotkeys_dirname() {
  local path="$(_get_readline_word_before_cursor)"
  [[ ${path} ]] || return
  _replace_readline "${path}" "$(dirname "${path}")/"
}
bind -x '"\C-d": "__hotkeys_dirname"'

# NOTE: FZF required below.
# -----------------
command -v fzf &>/dev/null || exit

if command -v jj &>/dev/null; then

  # Gets modified files in JJ repo.
  __hotkeys_jj_modified_files() {
    jj log --name-only --no-graph -T '' -r 'base::@ ~ immutable_heads()' | awk '!seen[$0]++'
  } 2>/dev/null
  __hotkeys_jj_modified_files_selector() {
    __hotkeys_jj_modified_files |
      fzf -0 -1 --multi --query "$(_get_readline_word_before_cursor)" |
      xargs
  }
  bind -x '"\C-x\C-f": "_select_widget __hotkeys_jj_modified_files_selector"'

fi
