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
