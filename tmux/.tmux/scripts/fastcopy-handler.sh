#!/usr/bin/env bash

echo > /tmp/fastcopy-handler.log
echo "args: $@" >> /tmp/fastcopy-handler.log
# echo "stdin: $(cat)" >> /tmp/fastcopy-handler.log
echo "pane id: $FASTCOPY_TARGET_PANE_ID" >> /tmp/fastcopy-handler.log

content="$(cat)"
[[ $content ]] || exit
printf -- "$content" | tmux load-buffer - && tmux paste-buffer -t "${FASTCOPY_TARGET_PANE_ID}"
