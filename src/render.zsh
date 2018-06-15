# ---------------------------------------------
# Helper functions

# Calculate how many spaces we need to put between two segments
function blox_helper__calculate_spaces() {

  # The segments
  local left=$1
  local right=$2

  # Strip ANSI escape characters
  local zero='%([BSUbfksu]|([FBK]|){*})'

  left=${#${(S%%)left//$~zero/}}
  right=${#${(S%%)right//$~zero/}}

  [[ $right -le 1 ]] && echo && return 0

  # Desired spaces length
  local termwidth
  (( termwidth = ${COLUMNS} - ${left} - ${right} ))

  # Calculate spaces
  local spacing=""
  for i in {3..$termwidth}; do
    spacing="${spacing} "
  done

  echo $spacing
}

# ---------------------------------------------
# Hooks

# Render the prompt
function blox_hook__render() {
  # `EXTENDED_GLOB` may be required by some blocks. `LOCAL_OPTIONS` will enable
  # the option locally, meaning it'll restore to its previous state after the
  # function exits.
  setopt EXTENDED_GLOB LOCAL_OPTIONS

  local upper_left
  local upper_right
  local lower_left
  local lower_right

  local spacing

  [[ -n "$BLOX_CONF__PROMPT_PREFIX" ]] \
    && echo -ne "$BLOX_CONF__PROMPT_PREFIX"

  # Segments
  upper_left="$(blox_helper__render_segment $BLOX_SEG__UPPER_LEFT)"
  upper_right="$(blox_helper__render_segment $BLOX_SEG__UPPER_RIGHT)"

  if [[ $BLOX_CONF__ONELINE == false ]]; then
    lower_left="$(blox_helper__render_segment $BLOX_SEG__LOWER_LEFT)"
    lower_right="$(blox_helper__render_segment $BLOX_SEG__LOWER_RIGHT)"

    spacing="$(blox_helper__calculate_spaces ${upper_left} ${upper_right})"
  fi

  # In oneline mode, we set $PROMPT to the
  # upper left segment and $RPROMPT to the upper
  # right. In multiline mode, $RPROMPT goes to the bottom
  # line so we set the first line of $PROMPT to the upper segments
  # while the second line to only the the lower left. Then,
  # $RPROMPT is set to the lower right segment.

  # Check if in oneline mode
  if [[ $BLOX_CONF__ONELINE == true ]]; then
    PROMPT=" ${upper_left} "
    RPROMPT="${upper_right}"
  else
    print -rP " %{${upper_left}%}${spacing}%{${upper_right}%} "
    PROMPT=" ${lower_left} "

    # Right prompt
    [[ "$lower_right" -gt 1 ]] \
      && RPROMPT='${lower_right}'
  fi

  # PROMPT2 (continuation interactive prompt)
  PROMPT2=' ${BLOX_BLOCK__SYMBOL_ALTERNATE} %_ >>> '
}
