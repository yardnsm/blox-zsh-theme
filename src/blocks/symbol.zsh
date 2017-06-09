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
