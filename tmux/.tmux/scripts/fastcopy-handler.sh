#!/usr/bin/env bash

copy=1
insert=1
clip=1

params="$(getopt -o '' -l copy,nocopy,insert,noinsert,clip,noclip -- "$@")" || exit 1
eval set -- "$params"
while [[ $# > 0 ]]; do
  case $1 in
    --copy )
      copy=1
      ;;
    --nocopy )
      copy=
      ;;
    --insert )
      insert=1
      ;;
    --noinsert )
      insert=
      ;;
    --clip )
      clip=1
      ;;
    --noclip )
      clip=
      ;;
    -- )
      shift
      break
      ;;
  esac
  shift
done

content="$(cat)"
[[ $content ]] || exit

if [[ $copy || $insert ]]; then
  bufferopts=()
  [[ $copy ]] || bufferopts=(-b fastcopy-handler-buffer)
  insert_if_needed() {
    [[ ! $insert ]] && true || tmux paste-buffer "${bufferopts[@]}" -t "${FASTCOPY_TARGET_PANE_ID}"
  }
  tmux set-buffer "${bufferopts[@]}" -- "$content" && insert_if_needed
fi

if [[ $clip ]]; then
  echo "$content" | xsel -ib
fi
