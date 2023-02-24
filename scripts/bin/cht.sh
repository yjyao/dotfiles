#!/usr/bin/env bash

# If being piped, pipe the output through with `cat`.
# Otherwise uses a $PAGER (default to `less`).
[ -t 1 ] && PAGER="${PAGER:-less}" || PAGER=cat

chtsh() {
  IFS=+
  local query="$*"
  # Print a half-screen wide horizontal devider bar
  # to mark the beginning of the results
  # because it is easy to get lost in the paragraphs and colors.
  echo "https://cht.sh/$query"
  printf '%*s\n' "$(( ${COLUMNS:-$(tput cols)} / 2 ))" '' | tr ' ' -
  curl -s "cht.sh/$query"
}

chtsh "$@" | "$PAGER"
