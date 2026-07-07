#!/bin/bash

rgf() {
  local rg_cmd="rg --column --line-number --no-heading --color=always --smart-case"
  : | fzf --ansi --disabled \
      --bind "start:reload:$rg_cmd {q}" \
      --bind "change:reload:sleep 0.1; $rg_cmd {q} || true" \
      --delimiter : \
      --preview 'bat --color=always --highlight-line {2} {1}' \
      --preview-window 'up,60%,border-bottom,+{2}+3/3' \
      --bind "enter:become(${EDITOR:-vi} {1} +{2})"
}
