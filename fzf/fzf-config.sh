#!/bin/bash
# fzf shell integration (keybindings Ctrl-T / Ctrl-R / Alt-C + completion)
source <(fzf --zsh)

export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'
export FZF_CTRL_T_OPTS="
  --preview 'bat --color=always --style=numbers {}'
  --preview-window 'right:60%:wrap'
  --bind 'ctrl-/:toggle-preview'"
