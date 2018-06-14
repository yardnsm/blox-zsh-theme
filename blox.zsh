#!/usr/bin/env zsh

#
# BLOX - zsh theme
#
# Author: Yarden Sod-Moriah
# License: MIT
# Repository: https://github.com/yardnsm/blox-zsh-theme
#

local -r __BLOX_ROOT=${0:A:h}

# ---------------------------------------------
# Initialize stuff

autoload -Uz promptinit && promptinit

source "$__BLOX_ROOT/src/blocks/bgjobs.zsh"
source "$__BLOX_ROOT/src/blocks/cwd.zsh"
source "$__BLOX_ROOT/src/blocks/git.zsh"
source "$__BLOX_ROOT/src/blocks/host.zsh"
source "$__BLOX_ROOT/src/blocks/nodejs.zsh"
source "$__BLOX_ROOT/src/blocks/symbol.zsh"
source "$__BLOX_ROOT/src/blocks/time.zsh"
source "$__BLOX_ROOT/src/blocks/vi_mode.zsh"

source "$__BLOX_ROOT/src/title.zsh"
source "$__BLOX_ROOT/src/segments.zsh"
source "$__BLOX_ROOT/src/render.zsh"

# ---------------------------------------------

BLOX_CONF__BLOCK_PREFIX="${BLOX_CONF__BLOCK_PREFIX:-[}"
BLOX_CONF__BLOCK_SUFFIX="${BLOX_CONF__BLOCK_SUFFIX:-]}"

BLOX_CONF__BLOCK_SEPARATOR="${BLOX_CONF__BLOCK_SEPARATOR:-" "}"

BLOX_CONF__PROMPT_PREFIX="${BLOX_CONF__PROMPT_PREFIX:-"\n"}"
BLOX_CONF__ONELINE="${BLOX_CONF__ONELINE:-false}"

# ---------------------------------------------
# Setup

prompt_blox_help() {
  cat <<'EOF'
Blox is a minimal and fast ZSH theme that shows you what you need. It consists of blocks, and you
can play with the order and change everything; it comes with some pre-defined blocks, but you can
create your own or even modify them.

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
