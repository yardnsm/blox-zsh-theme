# ---------------------------------------------
# NodeJS block

BLOX_BLOCK__NODEJS_SYMBOL="${BLOX_BLOCK__NODEJS_SYMBOL:-⬢}"
BLOX_BLOCK__NODEJS_COLOR="${BLOX_BLOCK__NODEJS_COLOR:-green}"

# ---------------------------------------------

function blox_block__nodejs_render() {

  [[ ! -f "$(pwd)/package.json" ]] \
    && return

  local node_version=$(node -v 2>/dev/null)
  local result=""

  if [[ ! -z "${node_version}" ]]; then
    result+="%F{${BLOX_BLOCK__NODEJS_COLOR}}"
    result+="${BLOX_CONF__BLOCK_PREFIX}${BLOX_BLOCK__NODEJS_SYMBOL} ${node_version:1}${BLOX_CONF__BLOCK_SUFFIX}"
    result+="%{$reset_color%}"
  fi

  echo $result
}
