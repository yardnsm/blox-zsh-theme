# ---------------------------------------------
# NodeJS block configurations

BLOX_BLOCK__NODEJS_SYMBOL="${BLOX_BLOCK__NODEJS_SYMBOL:-⬢}"
BLOX_BLOCK__NODEJS_COLOR="${BLOX_BLOCK__NODEJS_COLOR:-green}"

# ---------------------------------------------
# Helper functions

function blox_block__nodejs_helper__get_version() {
  echo -n "$(node -v 2>/dev/null)"
}

# ---------------------------------------------

function blox_block__nodejs() {
  [[ -f "$(pwd)/package.json" ]] \
    || return

  blox_helper__exists "node" \
    || return

  local node_version=$(blox_block__nodejs_helper__get_version)

  if [[ ! -z "${node_version}" ]]; then
    blox_helper__build_block \
      "${BLOX_BLOCK__NODEJS_COLOR}" \
      "${BLOX_BLOCK__NODEJS_SYMBOL} ${node_version:1}"
  fi
}
