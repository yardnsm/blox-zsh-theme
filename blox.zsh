#!/usr/bin/env zsh

#
# BLOX - zsh theme
#
# Author: Yarden Sod-Moriah <yardnsm@gmail.com> (yardnsm.net)
# License: MIT
# Repository: https://github.com/yardnsm/blox-zsh-theme
#

# --------------------------------------------- #
# | Background jobs block options
# --------------------------------------------- #
BLOX_BLOCK__BGJOBS_SYMBOL="${BLOX_BLOCK__BGJOBS_SYMBOL:-*}"
BLOX_BLOCK__BGJOBS_COLOR="${BLOX_BLOCK__BGJOBS_COLOR:-magenta}"

# --------------------------------------------- #
# | The block itself
# --------------------------------------------- #
function blox_block__bgjobs() {

  # The jobs
  bgjobs=$(jobs 2> /dev/null)

  # The result
  res=""

  # Check if there any
  if [[ ! $bgjobs == "" ]]; then
    res+="%{$fg[${BLOX_BLOCK__BGJOBS_COLOR}]%}"
    res+="${BLOX_CONF__BLOCK_PREFIX}${BLOX_BLOCK__BGJOBS_SYMBOL}${BLOX_CONF__BLOCK_SUFFIX}";
    res+="%{$reset_color%}"
  fi

  # Echo the block
  echo $res
}
# --------------------------------------------- #
# | CWD block options
# --------------------------------------------- #
BLOX_BLOCK__CWD_COLOR="${BLOX_BLOCK__CWD_COLOR:-blue}"
BLOX_BLOCK__CWD_TRUNC="${BLOX_BLOCK__CWD_TRUNC:-3}"

# --------------------------------------------- #
# | The block itself
# --------------------------------------------- #
function blox_block__cwd() {

  # Final result
  res=""

  # Append those
  res+="%{$fg_bold[${BLOX_BLOCK__CWD_COLOR}]%}"
  res+="%${BLOX_BLOCK__CWD_TRUNC}~";
  res+="%{$reset_color%}"

  # Echo result
  echo $res
}
# --------------------------------------------- #
# | Git block options
# --------------------------------------------- #

# Clean
BLOX_BLOCK__GIT_CLEAN_COLOR="${BLOX_BLOCK__GIT_CLEAN_COLOR:-green}"
BLOX_BLOCK__GIT_CLEAN_SYMBOL="${BLOX_BLOCK__GIT_CLEAN_SYMBOL:-☀︎}"

# Dirty
BLOX_BLOCK__GIT_DIRTY_COLOR="${BLOX_BLOCK__GIT_DIRTY_COLOR:-red}"
BLOX_BLOCK__GIT_DIRTY_SYMBOL="${BLOX_BLOCK__GIT_DIRTY_SYMBOL:-☂}"

# Unpulled
BLOX_BLOCK__GIT_UNPULLED_COLOR="${BLOX_BLOCK__GIT_UNPULLED_COLOR:-red}"
BLOX_BLOCK__GIT_UNPULLED_SYMBOL="${BLOX_BLOCK__GIT_UNPULLED_SYMBOL:-✈︎}"

# Unpushed
BLOX_BLOCK__GIT_UNPUSHED_COLOR="${BLOX_BLOCK__GIT_UNPUSHED_COLOR:-blue}"
BLOX_BLOCK__GIT_UNPUSHED_SYMBOL="${BLOX_BLOCK__GIT_UNPUSHED_SYMBOL:-☁︎}"

# --------------------------------------------- #
# | Themes
# --------------------------------------------- #
BLOX_BLOCK__GIT_THEME_CLEAN="%{$fg[${BLOX_BLOCK__GIT_CLEAN_COLOR}]%}$BLOX_BLOCK__GIT_CLEAN_SYMBOL%{$reset_color%}"
BLOX_BLOCK__GIT_THEME_DIRTY="%{$fg[${BLOX_BLOCK__GIT_DIRTY_COLOR}]%}$BLOX_BLOCK__GIT_DIRTY_SYMBOL%{$reset_color%}"
BLOX_BLOCK__GIT_THEME_UNPULLED="%{$fg[${BLOX_BLOCK__GIT_UNPULLED_COLOR}]%}$BLOX_BLOCK__GIT_UNPULLED_SYMBOL%{$reset_color%}"
BLOX_BLOCK__GIT_THEME_UNPUSHED="%{$fg[${BLOX_BLOCK__GIT_UNPUSHED_COLOR}]%}$BLOX_BLOCK__GIT_UNPUSHED_SYMBOL%{$reset_color%}"

# --------------------------------------------- #
# | Helper functions
# --------------------------------------------- #

# Get commit hash
function blox_block__git_helper__commit() {
  echo $(command git rev-parse --short HEAD  2> /dev/null)
}

# Get the current branch
function blox_block__git_helper__branch() {
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
  echo "${ref#refs/heads/}";
}

# Checks if working tree is dirty
blox_block__git_helper__dirty() {

  if [[ -z "$(git status --porcelain --ignore-submodules)" ]]; then

    # Clean
    echo $BLOX_BLOCK__GIT_THEME_CLEAN
  else

    # Dirty
    echo $BLOX_BLOCK__GIT_THEME_DIRTY
  fi
}

# Check remote status (pull/push)
function blox_block__git_helper__status() {

  local git_local=$(command git rev-parse @ 2> /dev/null)
  local git_remote=$(command git rev-parse @{u} 2> /dev/null)
  local git_base=$(command git merge-base @ @{u} 2> /dev/null)

  # First check that we have a remote
  if ! [[ ${git_remote} = "" ]]; then

    # Now do all that shit
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

# --------------------------------------------- #
# | The block itself
# --------------------------------------------- #
function blox_block__git() {

  if git rev-parse --git-dir > /dev/null 2>&1; then

    local branch="%F{242}$(blox_block__git_helper__branch)%{$reset_color%}"
    local remote="$(blox_block__git_helper__status)"
    local commit="%{$fg[magenta]%}[$(blox_block__git_helper__commit)]%{$reset_color%}"
    local dirtyclean="$(blox_block__git_helper__dirty)"

	  echo "${branch}${commit} ${dirtyclean}${remote}"
  fi
}
# --------------------------------------------- #
# | Host info block options
# --------------------------------------------- #

# User
BLOX_BLOCK__HOST_USER_SHOW_ALWAYS="${BLOX_BLOCK__HOST_USER_SHOW_ALWAYS:-false}"
BLOX_BLOCK__HOST_USER_COLOR="${BLOX_BLOCK__HOST_USER_COLOR:-yellow}"
BLOX_BLOCK__HOST_USER_ROOT_COLOR="${BLOX_BLOCK__HOST_USER_ROOT_COLOR:-red}"

# Machine
BLOX_BLOCK__HOST_MACHINE_SHOW_ALWAYS="${BLOX_BLOCK__HOST_MACHINE_SHOW_ALWAYS:-false}"
BLOX_BLOCK__HOST_MACHINE_COLOR="${BLOX_BLOCK__HOST_MACHINE_COLOR:-cyan}"

# --------------------------------------------- #
# | The block itself
# --------------------------------------------- #
function blox_block__host() {

  # The user's color
  USER_COLOR=$BLOX_BLOCK__HOST_USER_COLOR

  # Make the color red if the current user is root
  [[ $USER == "root" ]] && USER_COLOR=$BLOX_BLOCK__HOST_USER_ROOT_COLOR

  # The info
  info=""

  # Check if the user info is needed
  if [[ $BLOX_BLOCK__HOST_USER_SHOW_ALWAYS == true ]] || [[ $(who am i | awk '{print $1}') != $USER ]]; then
    info+="%{$fg[$USER_COLOR]%}%n%{$reset_color%}"
  fi

  # Check if the machine name is needed
  if [[ $BLOX_BLOCK__HOST_MACHINE_SHOW_ALWAYS == true ]] || [[ -n $SSH_CONNECTION ]]; then
    [[ $info != "" ]] && info+="@"
    info+="%{$fg[${BLOX_BLOCK__HOST_MACHINE_COLOR}]%}%m%{$reset_color%}"
  fi

  # Echo the info in need
  if [[ $info != "" ]]; then
    echo "$info:"
  fi
}
# --------------------------------------------- #
# | NodeJS block options
# --------------------------------------------- #
BLOX_BLOCK__NODEJS_SYMBOL="${BLOX_BLOCK__NODEJS_SYMBOL:-⬢}"
BLOX_BLOCK__NODEJS_COLOR="${BLOX_BLOCK__NODEJS_COLOR:-green}"

# --------------------------------------------- #
# | The block itself
# --------------------------------------------- #
function blox_block__nodejs() {

  [[ ! -f "$(pwd)/package.json" ]] && return
  local node_version=$(node -v 2>/dev/null)

  # The result
  res=""

  # Build the block
  if [[ ! -z "${node_version}" ]]; then
    res+="%{$fg[${BLOX_BLOCK__NODEJS_COLOR}]%}"
    res+="${BLOX_CONF__BLOCK_PREFIX}${BLOX_BLOCK__NODEJS_SYMBOL} ${node_version:1}${BLOX_CONF__BLOCK_SUFFIX}"
    res+="%{$reset_color%}"
  fi

  # Echo the block
  echo $res
}
# --------------------------------------------- #
# | Ruby block options
# --------------------------------------------- #
BLOX_BLOCK__RUBY_SYMBOL="${BLOX_BLOCK__RUBY_SYMBOL:-♢}"
BLOX_BLOCK__RUBY_COLOR="${BLOX_BLOCK__RUBY_COLOR:-red}"

# --------------------------------------------- #
# | The block itself
# --------------------------------------------- #
function blox_block__ruby() {

  [[ ! -f "$(pwd)/Gemfile" ]] && return
  local ruby_version=$(ruby --version | awk '{print $2}' | awk -F'p' '{print $1}')

  # The result
  res=""

  # Build the block
  if [[ ! -z "${ruby_version}" ]]; then
    res+="%{$fg[${BLOX_BLOCK__RUBY_COLOR}]%}"
    res+="${BLOX_CONF__BLOCK_PREFIX}${BLOX_BLOCK__RUBY_SYMBOL} ${ruby_version}${BLOX_CONF__BLOCK_SUFFIX}";
    res+="%{$reset_color%}"
  fi

  # Echo the block
  echo $res
}
# --------------------------------------------- #
# | Symbol block options
# --------------------------------------------- #

# Colors
BLOX_BLOCK__SYMBOL_COLOR="${BLOX_BLOCK__SYMBOL_COLOR:-cyan}"
BLOX_BLOCK__SYMBOL_EXIT_COLOR="${BLOX_BLOCK__SYMBOL_EXIT_COLOR:-red}"

# Symbols
BLOX_BLOCK__SYMBOL_SYMBOL="${BLOX_BLOCK__SYMBOL_SYMBOL:-❯}"
BLOX_BLOCK__SYMBOL_EXIT_SYMBOL="${BLOX_BLOCK__SYMBOL_EXIT_SYMBOL:-$BLOX_BLOCK__SYMBOL_SYMBOL}"
BLOX_BLOCK__SYMBOL_ALTERNATE="${BLOX_BLOCK__SYMBOL_ALTERNATE:-◇}"

# --------------------------------------------- #
# | The block itself
# --------------------------------------------- #
function blox_block__symbol() {

  # Final result
  res=""

  # Append those
  res+="%{$fg[${BLOX_BLOCK__SYMBOL_COLOR}]%}"
  res+="%(?.$BLOX_BLOCK__SYMBOL_SYMBOL.%{$fg[$BLOX_BLOCK__SYMBOL_EXIT_COLOR]%}$BLOX_BLOCK__SYMBOL_EXIT_SYMBOL)";
  res+="%{$reset_color%}"

  # Echo the result
  echo $res
}
# --------------------------------------------- #
# | Time block
# --------------------------------------------- #
function blox_block__time() {
  echo "${BLOX_CONF__BLOCK_PREFIX}%T${BLOX_CONF__BLOCK_SUFFIX}"
}
# --------------------------------------------- #
# | Initialize stuff
# --------------------------------------------- #

# Enable command substitution in prompt
setopt prompt_subst

# Initialize prompt
autoload -Uz promptinit && promptinit

# Initialize colors
autoload -Uz colors && colors

# Hooks
autoload -U add-zsh-hook

# --------------------------------------------- #
# | Core options
# --------------------------------------------- #
BLOX_CONF__BLOCK_PREFIX="${BLOX_CONF__BLOCK_PREFIX:-[}"
BLOX_CONF__BLOCK_SUFFIX="${BLOX_CONF__BLOCK_SUFFIX:-]}"
BLOX_CONF__ONELINE="${BLOX_CONF__ONELINE:-false}"

# --------------------------------------------- #
# | Segments
# --------------------------------------------- #

# Upper
BLOX_SEG__UPPER_LEFT="${BLOX_SEG__UPPER_LEFT:-blox_block__host,blox_block__cwd,blox_block__git}"
BLOX_SEG__UPPER_RIGHT="${BLOX_SEG__UPPER_RIGHT:-blox_block__bgjobs,blox_block__ruby,blox_block__nodejs,blox_block__time}"

# Lower
BLOX_SEG__LOWER_LEFT="${BLOX_SEG__LOWER_LEFT:-blox_block__symbol}"
BLOX_SEG__LOWER_RIGHT="${BLOX_SEG__LOWER_RIGHT:-}"

# --------------------------------------------- #
# | Helper functions
# --------------------------------------------- #

# Build a given segment
function blox_helper__build_segment() {

  # The segment to build
  segment=$1
  blocks=("${(@s/,/)segment}") # Don't ask me

  # The final segment
  res=""

  # Loop on each block
  for block in $blocks; do

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

  # The filter (to ignore ansi colors)
  local zero='%([BSUbfksu]|([FBK]|){*})'

  # Filtering
  left=${#${(S%%)left//$~zero/}}
  right=${#${(S%%)right//$~zero/}}

  # Desired spaces length
  local termwidth
  (( termwidth = ${COLUMNS} - ${left} - ${right} ))

  # Calculate spaces
  local spacing=""
  for i in {1..$termwidth}; do
    spacing="${spacing} "
  done

  # Echo'em
  echo $spacing
}

# --------------------------------------------- #
# | Hooks
# --------------------------------------------- #

# Set the title
function blox_hook__title() {

  # Show working directory in the title
  tab_label=${PWD/${HOME}/\~}
  echo -ne "\e]2;${tab_label}\a"
}

# Build the prompt
function blox_hook__build_prompt() {

  # Show working directory in the title
  tab_label=${PWD/${HOME}/\~}
  echo -ne "\e]2;${tab_label}\a"

  # The prompt consists of two part: PROMPT
  # and RPROMPT. In multiline prompt, RPROMPT goes
  # to the lower line. To solve this, we need to do stupid stuff.

  # Segments
  upper_left="$(blox_helper__build_segment $BLOX_SEG__UPPER_LEFT)"
  upper_right="$(blox_helper__build_segment $BLOX_SEG__UPPER_RIGHT)  "
  lower_left="$(blox_helper__build_segment $BLOX_SEG__LOWER_LEFT)"
  lower_right="$(blox_helper__build_segment $BLOX_SEG__LOWER_RIGHT) "

  # Spacessss
  spacing="$(blox_helper__calculate_spaces ${upper_left} ${upper_right})"

  # In oneline mode, we set $PROMPT to the
  # upper left segment and $RPROMPT to the upper
  # right. In multiline mode, $RPROMPT goes to the bottom
  # line so we set the first line of $PROMPT to the upper segments
  # while the second line to only the the lower left. Then,
  # $RPROMPT is set to the lower right segment.

  # Check if in oneline mode
  if [[ $BLOX_CONF__ONELINE == true ]]; then

    # Setting only the upper segments
    PROMPT='
${upper_left} '

    # Right segment
    RPROMPT='${upper_right}'
  else

    # The prompt
    PROMPT='
${upper_left}${spacing}${upper_right}
${lower_left} '

    # Right prompt
    RPROMPT='${lower_right}'
  fi

  # PROMPT2 (continuation interactive prompt)
  PROMPT2=' ${BLOX_BLOCK__SYMBOL_ALTERNATE} %_ >>> '
}

# Async stuff (for git fetch)
ASYNC_PROC=0
function blox_hook__async() {

  function async {

    # Fetch the data from git
    is_fetchable=$(git rev-parse HEAD &> /dev/null)
    [[ is_fetchable ]] && git fetch &> /dev/null

    # Signal the parent shell to update the prompt
    kill -s USR2 $$
  }

  # Kill child if necessary
  if [[ "${ASYNC_PROC}" != 0 ]]; then
    kill -s HUP $ASYNC_PROC > /dev/null 2>&1 || :
  fi

  # Build the prompt in a background job
  async &!

  # Set process pid
  ASYNC_PROC=$!
}

# 'Catch' the async process
function TRAPUSR2 {

  # Re-build the prompt
  blox_hook__build_prompt

  # Reset process number
  ASYNC_PROC=0
}

# --------------------------------------------- #
# | Setup hooks
# --------------------------------------------- #

# Build the prompt
add-zsh-hook precmd blox_hook__build_prompt

# Start sync process
add-zsh-hook precmd blox_hook__async

# Set title
add-zsh-hook precmd blox_hook__title
