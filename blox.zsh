#!/usr/bin/env zsh

#
# BLOX - zsh theme
#
# Author: Yarden Sod-Moriah
# License: MIT
# Repository: https://github.com/yardnsm/blox-zsh-theme
#

# ---------------------------------------------
# Initialize stuff

autoload -Uz promptinit && promptinit

source './src/blocks/bgjobs.zsh'
source './src/blocks/cwd.zsh'
source './src/blocks/git.zsh'
source './src/blocks/host.zsh'
source './src/blocks/nodejs.zsh'
source './src/blocks/symbol.zsh'
source './src/blocks/time.zsh'

source './src/title.zsh'
source './src/blocks.zsh'
source './src/segments.zsh'
source './src/render.zsh'

# ---------------------------------------------

BLOX_CONF__PROMPT_PREFIX="${BLOX_CONF__PROMPT_PREFIX:-"$'\n'"}"
BLOX_CONF__PROMPT_SUFFIX="${BLOX_CONF__PROMPT_SUFFIX:-""}"

BLOX_CONF__BLOCK_PREFIX="${BLOX_CONF__BLOCK_PREFIX:-[}"
BLOX_CONF__BLOCK_SUFFIX="${BLOX_CONF__BLOCK_SUFFIX:-]}"

BLOX_CONF__BLOCK_SEPARATOR="${BLOX_CONF__BLOCK_SEPARATOR:-" "}"

BLOX_CONF__ONELINE="${BLOX_CONF__ONELINE:-false}"
BLOX_CONF__NEWLINE="${BLOX_CONF__NEWLINE:-true}"

# ---------------------------------------------
# Setup

prompt_blox_help() {
  cat <<'EOF'
Blox is a minimal and fast ZSH theme that shows you what you need. It consists of blocks, and you
can play with the order and change everything; it comes with some pre-defined blocks, but you can
create your own or even modify them.

Configuration:

See: https://github.com/yardnsm/blox-zsh-theme

You can invoke it thus:

  prompt blox

EOF
}

prompt_blox_setup() {
  setopt prompt_subst

  autoload -Uz colors && colors
  autoload -U add-zsh-hook
  autoload -Uz vcs_info

  add-zsh-hook precmd blox_hook__render
  add-zsh-hook precmd blox_hook__title

  return 0
}

prompt_blox_setup "$@"
