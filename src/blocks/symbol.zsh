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
  res+="%(?.$BLOX_BLOCK__SYMBOL_SYMBOL.%{$fg[red]%}$BLOX_BLOCK__SYMBOL_EXIT_SYMBOL)";
  res+="%{$reset_color%}"

  # Echo the result
  echo $res
}
