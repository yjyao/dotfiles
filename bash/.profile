# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login exists.

# Returns true if `$dir` satisfies both:
#   - exists
#   - is *not* already in `$PATH`
_can_add_to_path() {
  local dir="${1?}"
  dir="${dir%/}"
  [ -d "${dir}" ] &&
    case "${PATH}" in
      *:${dir}:*|*:${dir}/:*) false ;;
      *) true ;;
    esac
}

# Prepend `$1` to `$PATH` if appropriate.
try_prepend_path() {
  _can_add_to_path "$1" && PATH="$1${PATH:+:${PATH}}"
}

# Append `$1` to `$PATH` if appropriate.
try_append_path() {
  _can_add_to_path "$1" && PATH="${PATH:+${PATH}:}$1"
}

# Set `$PATH` so it includes programs installed only for `$USER`.
try_prepend_path "$HOME/.local/bin"

# Set `$PATH` so it includes user's private bin.
try_prepend_path "$HOME/bin"
try_prepend_path "$HOME/bin.local"

# Set `$PATH` so it includes golang.
try_append_path '/usr/local/go/bin'
try_append_path "$HOME/go/bin"

# Set `$PATH` so it includes fzf.
try_append_path "$HOME/.fzf/bin"

# Import local profile configs.
[ -r "$HOME/.profile.local" ] && . "$HOME/.profile.local"
if [ -d "$HOME/.profile.d" ]; then
  for f in "$HOME"/.profile.d/*.sh; do
    [ -r "$f" ] && . "$f"
  done
fi

# Import bashrc if available and running bash.
[ -n "$BASH_VERSION" ] && [ -r "$HOME/.bashrc" ] && . "$HOME/.bashrc"
