# --------------------------------------------- #
# | Block options
# --------------------------------------------- #

# Colors
BLOX_CORE__SYMBOL_COLOR="${BLOX_CORE__SYMBOL_COLOR:-cyan}"
BLOX_CORE__SYMBOL_EXIT_COLOR="${BLOX_CORE__SYMBOL_EXIT_COLOR:-red}"

# Symbols
BLOX_CORE__SYMBOL_SYMBOL="${BLOX_CORE__SYMBOL_SYMBOL:-❯}"
BLOX_CORE__SYMBOL_EXIT_SYMBOL="${BLOX_CORE__SYMBOL_EXIT_SYMBOL:-$BLOX_CORE__SYMBOL_SYMBOL}"
BLOX_CORE__SYMBOL_ALTERNATE="${BLOX_CORE__SYMBOL_ALTERNATE:-◇}"

# --------------------------------------------- #
# | The block itself
# --------------------------------------------- #
function blox_core__symbol() {

  # Final result
  res=""

  # Append those
  res+="%{$fg[${BLOX_CORE__SYMBOL_COLOR}]%}"
  res+="%(?.$BLOX_CORE__SYMBOL_SYMBOL.%{$fg[red]%}$BLOX_CORE__SYMBOL_EXIT_SYMBOL)";
  res+="%{$reset_color%}"

  # Echo the result
  echo $res
}
