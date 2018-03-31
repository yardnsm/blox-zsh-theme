# ---------------------------------------------
# Background jobs block

BLOX_BLOCK__BGJOBS_SYMBOL="${BLOX_BLOCK__BGJOBS_SYMBOL:-*}"
BLOX_BLOCK__BGJOBS_COLOR="${BLOX_BLOCK__BGJOBS_COLOR:-magenta}"

# ---------------------------------------------

function blox_block__bgjobs() {
  local bgjobs=$(jobs | wc -l | awk '{print $1}' 2> /dev/null)
  local result=""

  if [[ ! $bgjobs == "0" ]]; then
    result+="%F{${BLOX_BLOCK__BGJOBS_COLOR}}"
    result+="${BLOX_CONF__BLOCK_PREFIX}${BLOX_BLOCK__BGJOBS_SYMBOL}${bgjobs}${BLOX_CONF__BLOCK_SUFFIX}";
    result+="%{$reset_color%}"
  fi

  echo $result
}
