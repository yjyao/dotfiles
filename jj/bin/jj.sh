#!/usr/bin/env bash

: ${JJ_ADDON_DIR:="${XDG_CONFIG_HOME:-$HOME/.config/}jj/addons"}

progname="$(basename "$0")"

die() {
  >&2 echo "$progname: $@"
  exit 1
}

# Do NOT symlink this script to `jj` in `$PATH`!
# That will result in an infinite loop.
# Instead, define `jj` as a function or alias to `jj.sh`.
# The `which` command, unlike `command -v`, only returns files in `$PATH`
# so function definitions are invisible to it.
JJ="$(which jj 2>/dev/null)" || die 'https://github.com/martinvonz/jj is required.'

(( $# == 0 )) && { "$JJ"; exit "$?"; }

cmd="$1"; shift
addon_script="${JJ_ADDON_DIR}/$cmd"
if [[ -f "${addon_script}" && -x "${addon_script}" ]]; then
  "${addon_script}" "$@"
else
  "$JJ" "$cmd" "$@"
fi
