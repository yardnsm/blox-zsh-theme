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

source "$__BLOX_ROOT/src/utils.zsh"

source "$__BLOX_ROOT/src/blocks/bgjobs.zsh"
source "$__BLOX_ROOT/src/blocks/cwd.zsh"
source "$__BLOX_ROOT/src/blocks/exec_time.zsh"
source "$__BLOX_ROOT/src/blocks/git.zsh"
source "$__BLOX_ROOT/src/blocks/host.zsh"
source "$__BLOX_ROOT/src/blocks/nodejs.zsh"
source "$__BLOX_ROOT/src/blocks/pyenv.zsh"
source "$__BLOX_ROOT/src/blocks/symbol.zsh"
source "$__BLOX_ROOT/src/blocks/time.zsh"
source "$__BLOX_ROOT/src/blocks/virtualenv.zsh"
source "$__BLOX_ROOT/src/blocks/awsprofile.zsh"

source "$__BLOX_ROOT/src/title.zsh"
source "$__BLOX_ROOT/src/segments.zsh"
source "$__BLOX_ROOT/src/render.zsh"

# ---------------------------------------------

BLOX_CONF__BLOCK_PREFIX="${BLOX_CONF__BLOCK_PREFIX:-[}"
BLOX_CONF__BLOCK_SUFFIX="${BLOX_CONF__BLOCK_SUFFIX:-]}"

BLOX_CONF__BLOCK_SEPARATOR="${BLOX_CONF__BLOCK_SEPARATOR:-" "}"

BLOX_CONF__ONELINE="${BLOX_CONF__ONELINE:-false}"
BLOX_CONF__UNIFIED_PROMPT="${BLOX_CONF__UNIFIED_PROMPT:-false}"

# Allow setting null/empty values (#6)
[[ -z "${BLOX_CONF__PROMPT_PREFIX+1}" ]] \
  && BLOX_CONF__PROMPT_PREFIX="\n"

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

  zmodload zsh/datetime
  zmodload zsh/zle

  autoload -Uz colors && colors
  autoload -U add-zsh-hook
  autoload -Uz vcs_info

  add-zsh-hook precmd blox_hook__render
  add-zsh-hook precmd blox_hook__title

  # See ./src/blocks/exec_time.zsh
  add-zsh-hook preexec blox_block__exec_time_hook__preexec
  add-zsh-hook precmd blox_block__exec_time_hook__precmd

  return 0
}

prompt_blox_setup "$@"
