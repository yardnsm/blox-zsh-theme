# ---------------------------------------------
# Background jobs block

BLOX_BLOCK__BGJOBS_SYMBOL="${BLOX_BLOCK__BGJOBS_SYMBOL:-*}"
BLOX_BLOCK__BGJOBS_COLOR="${BLOX_BLOCK__BGJOBS_COLOR:-magenta}"

# ---------------------------------------------

function blox_block__bgjobs() {
  bgjobs=$(jobs | wc -l | awk '{print $1}' 2> /dev/null)
  res=""

  if [[ ! $bgjobs == "0" ]]; then
    res+="%{$fg[${BLOX_BLOCK__BGJOBS_COLOR}]%}"
    res+="${BLOX_CONF__BLOCK_PREFIX}${BLOX_BLOCK__BGJOBS_SYMBOL}${bgjobs}${BLOX_CONF__BLOCK_SUFFIX}";
    res+="%{$reset_color%}"
  fi

  echo $res
}
