# ---------------------------------------------
# Time block

BLOX_BLOCK__TIME_COLOR="${BLOX_BLOCK__TIME_COLOR:-white}"

# ---------------------------------------------

function blox_block__time() {
  blox_util__build_block \
    "${BLOX_BLOCK__TIME_COLOR}" \
    "%T"
}
