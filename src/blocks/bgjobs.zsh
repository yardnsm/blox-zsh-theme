# ---------------------------------------------
# Background jobs block configurations

BLOX_BLOCK__BGJOBS_SYMBOL="${BLOX_BLOCK__BGJOBS_SYMBOL:-*}"
BLOX_BLOCK__BGJOBS_COLOR="${BLOX_BLOCK__BGJOBS_COLOR:-magenta}"

# ---------------------------------------------

function blox_block__bgjobs() {
  local bgjobs=$(jobs | wc -l | awk '{print $1}' 2> /dev/null)

  if [[ ! $bgjobs == "0" ]]; then
    blox_helper__build_block \
      "${BLOX_BLOCK__BGJOBS_COLOR}" \
      "${BLOX_BLOCK__BGJOBS_SYMBOL}${bgjobs}"
  fi
}
