#!/usr/bin/env zsh

#
# BLOX - zsh theme
#
# Author: Yarden Sod-Moriah <yardnsm@gmail.com>
# License: MIT
# Repository: https://github.com/yardnsm/blox-zsh-theme
#

# ---------------------------------------------
# Background jobs block

BLOX_BLOCK__BGJOBS_SYMBOL="${BLOX_BLOCK__BGJOBS_SYMBOL:-*}"
BLOX_BLOCK__BGJOBS_COLOR="${BLOX_BLOCK__BGJOBS_COLOR:-magenta}"

# ---------------------------------------------

function blox_block__bgjobs() {
  bgjobs=$(jobs | wc -l | awk '{print $1}' 2> /dev/null)
  res=""

  if [[ ! $bgjobs == "0" ]]; then
    res+="%F{${BLOX_BLOCK__BGJOBS_COLOR}}"
    res+="${BLOX_CONF__BLOCK_PREFIX}${BLOX_BLOCK__BGJOBS_SYMBOL}${bgjobs}${BLOX_CONF__BLOCK_SUFFIX}";
    res+="%{$reset_color%}"
  fi

  echo $res
}
# ---------------------------------------------
# CWD block

BLOX_BLOCK__CWD_COLOR="${BLOX_BLOCK__CWD_COLOR:-blue}"
BLOX_BLOCK__CWD_TRUNC="${BLOX_BLOCK__CWD_TRUNC:-3}"

# ---------------------------------------------

function blox_block__cwd() {
  res="%F{${BLOX_BLOCK__CWD_COLOR}}"
  res+="%${BLOX_BLOCK__CWD_TRUNC}~";
  res+="%{$reset_color%}"

  echo $res
}
# ---------------------------------------------
# Git block options

# Colors
BLOX_BLOCK__GIT_BRANCH_COLOR="${BLOX_BLOCK__GIT_BRANCH_COLOR:-242}"
BLOX_BLOCK__GIT_COMMIT_COLOR="${BLOX_BLOCK__GIT_COMMIT_COLOR:-magenta}"

# Clean
BLOX_BLOCK__GIT_CLEAN_COLOR="${BLOX_BLOCK__GIT_CLEAN_COLOR:-green}"
BLOX_BLOCK__GIT_CLEAN_SYMBOL="${BLOX_BLOCK__GIT_CLEAN_SYMBOL:-✔}"

# Dirty
BLOX_BLOCK__GIT_DIRTY_COLOR="${BLOX_BLOCK__GIT_DIRTY_COLOR:-red}"
BLOX_BLOCK__GIT_DIRTY_SYMBOL="${BLOX_BLOCK__GIT_DIRTY_SYMBOL:-✘}"

# Unpulled
BLOX_BLOCK__GIT_UNPULLED_COLOR="${BLOX_BLOCK__GIT_UNPULLED_COLOR:-red}"
BLOX_BLOCK__GIT_UNPULLED_SYMBOL="${BLOX_BLOCK__GIT_UNPULLED_SYMBOL:-⇣}"

# Unpushed
BLOX_BLOCK__GIT_UNPUSHED_COLOR="${BLOX_BLOCK__GIT_UNPUSHED_COLOR:-blue}"
BLOX_BLOCK__GIT_UNPUSHED_SYMBOL="${BLOX_BLOCK__GIT_UNPUSHED_SYMBOL:-⇡}"

# ---------------------------------------------
# Themes

BLOX_BLOCK__GIT_THEME_CLEAN="%F{${BLOX_BLOCK__GIT_CLEAN_COLOR}]%}$BLOX_BLOCK__GIT_CLEAN_SYMBOL%{$reset_color%}"
BLOX_BLOCK__GIT_THEME_DIRTY="%F{${BLOX_BLOCK__GIT_DIRTY_COLOR}]%}$BLOX_BLOCK__GIT_DIRTY_SYMBOL%{$reset_color%}"
BLOX_BLOCK__GIT_THEME_UNPULLED="%F{${BLOX_BLOCK__GIT_UNPULLED_COLOR}]%}$BLOX_BLOCK__GIT_UNPULLED_SYMBOL%{$reset_color%}"
BLOX_BLOCK__GIT_THEME_UNPUSHED="%F{${BLOX_BLOCK__GIT_UNPUSHED_COLOR}]%}$BLOX_BLOCK__GIT_UNPUSHED_SYMBOL%{$reset_color%}"

# ---------------------------------------------
# Helper functions

# Get commit hash (short)
function blox_block__git_helper__commit() {
  echo $(command git rev-parse --short HEAD  2> /dev/null)
}

# Get the current branch name
function blox_block__git_helper__branch() {
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
  echo "${ref#refs/heads/}";
}

# Echo the appropriate symbol for branch's status
blox_block__git_helper__status() {

  if [[ -z "$(git status --porcelain --ignore-submodules)" ]]; then
    echo $BLOX_BLOCK__GIT_THEME_CLEAN
  else
    echo $BLOX_BLOCK__GIT_THEME_DIRTY
  fi
}

# Echo the appropriate symbol for branch's remote status (pull/push)
# Need to do 'git fetch' before
function blox_block__git_helper__remote_status() {

  local git_local=$(command git rev-parse @ 2> /dev/null)
  local git_remote=$(command git rev-parse @{u} 2> /dev/null)
  local git_base=$(command git merge-base @ @{u} 2> /dev/null)

  # First check that we have a remote
  if ! [[ ${git_remote} = "" ]]; then
    if [[ ${git_local} = ${git_remote} ]]; then
      echo ""
    elif [[ ${git_local} = ${git_base} ]]; then
      echo " $BLOX_BLOCK__GIT_THEME_UNPULLED"
    elif [[ ${git_remote} = ${git_base} ]]; then
      echo " $BLOX_BLOCK__GIT_THEME_UNPUSHED"
    else
      echo " $BLOX_BLOCK__GIT_THEME_UNPULLED $BLOX_BLOCK__GIT_THEME_UNPUSHED"
    fi
  fi
}

# Checks if cwd is a git repo
function blox_block__git_helper__is_git_repo() {
  return $(git rev-parse --git-dir > /dev/null 2>&1)
}

# ---------------------------------------------
# The block itself

function blox_block__git() {

  if blox_block__git_helper__is_git_repo; then

    local branch="$(blox_block__git_helper__branch)"
    local commit="$(blox_block__git_helper__commit)"
    local b_status="$(blox_block__git_helper__status)"
    local remote="$(blox_block__git_helper__remote_status)"

    res=""

    res+="%F{${BLOX_BLOCK__GIT_BRANCH_COLOR}}${branch}%{$reset_color%}"
    res+="%F{${BLOX_BLOCK__GIT_COMMIT_COLOR}}${BLOX_CONF__BLOCK_PREFIX}${commit}${BLOX_CONF__BLOCK_SUFFIX}%{$reset_color%} "
    res+="${b_status}"
    res+="${remote}"

    echo $res
  fi
}
# ---------------------------------------------
# Host info block

# User
BLOX_BLOCK__HOST_USER_SHOW_ALWAYS="${BLOX_BLOCK__HOST_USER_SHOW_ALWAYS:-false}"
BLOX_BLOCK__HOST_USER_COLOR="${BLOX_BLOCK__HOST_USER_COLOR:-yellow}"
BLOX_BLOCK__HOST_USER_ROOT_COLOR="${BLOX_BLOCK__HOST_USER_ROOT_COLOR:-red}"

# Machine
BLOX_BLOCK__HOST_MACHINE_SHOW_ALWAYS="${BLOX_BLOCK__HOST_MACHINE_SHOW_ALWAYS:-false}"
BLOX_BLOCK__HOST_MACHINE_COLOR="${BLOX_BLOCK__HOST_MACHINE_COLOR:-cyan}"

# ---------------------------------------------
# The block itself

function blox_block__host() {
  USER_COLOR=$BLOX_BLOCK__HOST_USER_COLOR
  [[ $USER == "root" ]] && USER_COLOR=$BLOX_BLOCK__HOST_USER_ROOT_COLOR

  info=""

  # Check if the user info is needed
  if [[ $BLOX_BLOCK__HOST_USER_SHOW_ALWAYS == true ]] || [[ $(whoami | awk '{print $1}') != $USER ]]; then
    info+="%F{$USER_COLOR]%}%n%{$reset_color%}"
  fi

  # Check if the machine name is needed
  if [[ $BLOX_BLOCK__HOST_MACHINE_SHOW_ALWAYS == true ]] || [[ -n $SSH_CONNECTION ]]; then
    [[ $info != "" ]] && info+="@"
    info+="%F{${BLOX_BLOCK__HOST_MACHINE_COLOR}]%}%m%{$reset_color%}"
  fi

  if [[ $info != "" ]]; then
    echo "$info:"
  fi
}
# ---------------------------------------------
# NodeJS block

BLOX_BLOCK__NODEJS_SYMBOL="${BLOX_BLOCK__NODEJS_SYMBOL:-⬢}"
BLOX_BLOCK__NODEJS_COLOR="${BLOX_BLOCK__NODEJS_COLOR:-green}"

# ---------------------------------------------

function blox_block__nodejs() {

  [[ ! -f "$(pwd)/package.json" ]] && return
  local node_version=$(node -v 2>/dev/null)

  res=""

  if [[ ! -z "${node_version}" ]]; then
    res+="%F{${BLOX_BLOCK__NODEJS_COLOR}}"
    res+="${BLOX_CONF__BLOCK_PREFIX}${BLOX_BLOCK__NODEJS_SYMBOL} ${node_version:1}${BLOX_CONF__BLOCK_SUFFIX}"
    res+="%{$reset_color%}"
  fi

  echo $res
}
# ---------------------------------------------
# Symbol block

# Colors
BLOX_BLOCK__SYMBOL_COLOR="${BLOX_BLOCK__SYMBOL_COLOR:-cyan}"
BLOX_BLOCK__SYMBOL_EXIT_COLOR="${BLOX_BLOCK__SYMBOL_EXIT_COLOR:-red}"

# Symbols
BLOX_BLOCK__SYMBOL_SYMBOL="${BLOX_BLOCK__SYMBOL_SYMBOL:-❯}"
BLOX_BLOCK__SYMBOL_EXIT_SYMBOL="${BLOX_BLOCK__SYMBOL_EXIT_SYMBOL:-$BLOX_BLOCK__SYMBOL_SYMBOL}"
BLOX_BLOCK__SYMBOL_ALTERNATE="${BLOX_BLOCK__SYMBOL_ALTERNATE:-◇}"

# ---------------------------------------------

function blox_block__symbol() {
  res="%F{${BLOX_BLOCK__SYMBOL_COLOR}}"
  res+="%(?.$BLOX_BLOCK__SYMBOL_SYMBOL.%F{$BLOX_BLOCK__SYMBOL_EXIT_COLOR}$BLOX_BLOCK__SYMBOL_EXIT_SYMBOL)";
  res+="%{$reset_color%}"
  echo $res
}
# ---------------------------------------------
# Time block

function blox_block__time() {
  echo "${BLOX_CONF__BLOCK_PREFIX}%T${BLOX_CONF__BLOCK_SUFFIX}"
}
# ---------------------------------------------
# Initialize stuff

# Initialize prompt
autoload -Uz promptinit && promptinit

# ---------------------------------------------

# Core options
BLOX_CONF__BLOCK_PREFIX="${BLOX_CONF__BLOCK_PREFIX:-[}"
BLOX_CONF__BLOCK_SUFFIX="${BLOX_CONF__BLOCK_SUFFIX:-]}"
BLOX_CONF__ONELINE="${BLOX_CONF__ONELINE:-false}"
BLOX_CONF__NEWLINE="${BLOX_CONF__NEWLINE:-true}"

BLOX_CHAR__SPACE=" "
BLOX_CHAR__NEWLINE="
"

# ---------------------------------------------
# Segments

# Defualts
BLOX_SEG_DEFAULT__UPPER_LEFT=(blox_block__host blox_block__cwd blox_block__git)
BLOX_SEG_DEFAULT__UPPER_RIGHT=(blox_block__bgjobs blox_block__nodejs blox_block__time)
BLOX_SEG_DEFAULT__LOWER_LEFT=(blox_block__symbol)
BLOX_SEG_DEFAULT__LOWER_RIGHT=( )

# Upper
BLOX_SEG__UPPER_LEFT=${BLOX_SEG__UPPER_LEFT:-$BLOX_SEG_DEFAULT__UPPER_LEFT}
BLOX_SEG__UPPER_RIGHT=${BLOX_SEG__UPPER_RIGHT:-$BLOX_SEG_DEFAULT__UPPER_RIGHT}

# Lower
BLOX_SEG__LOWER_LEFT=${BLOX_SEG__LOWER_LEFT:-$BLOX_SEG_DEFAULT__LOWER_LEFT}
BLOX_SEG__LOWER_RIGHT=${BLOX_SEG__LOWER_RIGHT:-$BLOX_SEG_DEFAULT__LOWER_RIGHT}

# ---------------------------------------------
# Helper functions

# Build a given segment
function blox_helper__build_segment() {

  # The segment to build
  segment=(`echo $@`)

  # The final segment
  res=""

  # Loop on each block
  for block in ${segment[@]}; do

    # Get the block data
    blockData="$($block)"

    # Append to result
    [[ $blockData != "" ]] && [[ -n $blockData ]] && res+=" $blockData"
  done

  # Echo the result
  echo $res
}

# Calculate how many spaces we need to put
# between two strings
function blox_helper__calculate_spaces() {

  # The segments
  left=$1
  right=$2

  # The filter (to ignore ansi escapes)
  local zero='%([BSUbfksu]|([FBK]|){*})'

  # Filtering
  left=${#${(S%%)left//$~zero/}}
  right=${#${(S%%)right//$~zero/}}

  # We don't need spaces if there nothing on the right
  [[ $right -le 1 ]] && echo && return 0

  # Desired spaces length
  local termwidth
  (( termwidth = ${COLUMNS} - ${left} - ${right} ))

  # Calculate spaces
  local spacing=""
  for i in {1..$termwidth}; do
    spacing="${spacing} "
  done

  echo $spacing
}

# ---------------------------------------------
# Hooks

# Set the title to cwd
function blox_hook__title() {
  tab_label=${PWD/${HOME}/\~}
  echo -ne "\e]2;${tab_label}\a"
}

# Build the prompt
function blox_hook__build_prompt() {

  # The prompt consists of two part: PROMPT
  # and RPROMPT. In multiline prompt, RPROMPT goes
  # to the lower line. To solve this, we need to do stupid stuff.

  # Segments
  upper_left="$(blox_helper__build_segment $BLOX_SEG__UPPER_LEFT)"
  upper_right="$(blox_helper__build_segment $BLOX_SEG__UPPER_RIGHT) "
  lower_left="$(blox_helper__build_segment $BLOX_SEG__LOWER_LEFT)"
  lower_right="$(blox_helper__build_segment $BLOX_SEG__LOWER_RIGHT) "

  spacing="$(blox_helper__calculate_spaces ${upper_left} ${upper_right})"

  # Should we add a newline?
  [[ $BLOX_CONF__NEWLINE != false ]] && print ""

  # In oneline mode, we set $PROMPT to the
  # upper left segment and $RPROMPT to the upper
  # right. In multiline mode, $RPROMPT goes to the bottom
  # line so we set the first line of $PROMPT to the upper segments
  # while the second line to only the the lower left. Then,
  # $RPROMPT is set to the lower right segment.

  # Check if in oneline mode
  if [[ $BLOX_CONF__ONELINE == true ]]; then

    # Setting only the upper segments
    PROMPT='${upper_left} '

    # Right segment
    RPROMPT='${upper_right}'
  else

    # The prompt
    PROMPT='%{${upper_left}%}${spacing}%{${upper_right}%}
${lower_left} '

    # Right prompt
    RPROMPT='${lower_right}'
  fi

  # PROMPT2 (continuation interactive prompt)
  PROMPT2=' ${BLOX_BLOCK__SYMBOL_ALTERNATE} %_ >>> '
}

# ---------------------------------------------
# Setup

prompt_blox_help() {
  cat <<'EOF'
Blox is a minimal and fast ZSH theme that shows you what you need. It consists of blocks,
and you can play with the order and change everything; it comes with some
pre-defined blocks, but you can create your own or even modify them.

You can consider Blox as a "framework", since you can do whatever you want with it.

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

  add-zsh-hook precmd blox_hook__build_prompt
  add-zsh-hook precmd blox_hook__title

  return 0
}

prompt_blox_setup "$@"
