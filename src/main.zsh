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
