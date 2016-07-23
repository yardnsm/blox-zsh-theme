# --------------------------------------------- #
# | NodeJS block options
# --------------------------------------------- #
BLOX_BLOCK__NODEJS_SYMBOL="${BLOX_BLOCK__NODEJS_SYMBOL:-⬢}"
BLOX_BLOCK__NODEJS_COLOR="${BLOX_BLOCK__NODEJS_COLOR:-green}"

# --------------------------------------------- #
# | The block itself
# --------------------------------------------- #
function blox_block__nodejs() {

  [[ ! -f "$(pwd)/package.json" ]] && return
  local node_version=$(node -v 2>/dev/null)

  # The result
  res=""

  # Build the block
  if [[ ! -z "${node_version}" ]]; then
    res+="%{$fg[${BLOX_BLOCK__NODEJS_COLOR}]%}"
    res+="${BLOX_CONF__BLOCK_PREFIX}${BLOX_BLOCK__NODEJS_SYMBOL} ${node_version:1}${BLOX_CONF__BLOCK_SUFFIX}";
    res+="%{$reset_color%}"
  fi

  # Echo the block
  echo $res
}
