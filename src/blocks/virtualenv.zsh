# ---------------------------------------------
# Virtualenv block configurations

BLOX_BLOCK__VIRTUALENV_COLOR="${BLOX_BLOCK__VIRTUALENV_COLOR:-green}"

# ---------------------------------------------

function blox_block__virtualenv() {
  [[ -n "$VIRTUAL_ENV" ]] \
    || return

  blox_helper__build_block \
    "${BLOX_BLOCK__VIRTUALENV_COLOR}" \
    "ve:${VIRTUAL_ENV:t}"
}
