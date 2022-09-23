#!/usr/bin/env bash

: ${PAGER:=less}
# Don't send results to a pager if being piped.
[ -t 1 ] || PAGER=cat

chtsh() {
  # Print a half-screen wide horizontal devider bar
  # to mark the beginning of the results
  # because it is easy to get lost in the paragraphs and colors.
  printf '%*s\n' "$(( ${COLUMNS:-$(tput cols)} / 2 ))" '' | tr ' ' -
  IFS=+
  curl -s "cht.sh/$*"
}

chtsh "$@" | $PAGER
