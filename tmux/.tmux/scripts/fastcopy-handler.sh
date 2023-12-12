#!/usr/bin/env bash

content="$(cat)"
[[ $content ]] || exit
tmux set-buffer -- "$content" && tmux paste-buffer -t "${FASTCOPY_TARGET_PANE_ID}"
