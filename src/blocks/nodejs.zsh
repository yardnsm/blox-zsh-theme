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
  # Support for `zsh-nvm` (https://github.com/lukechilds/zsh-nvm)
  # When `$NVM_LAZY_LOAD` is set, getting node's version is slowing the prompt.
  # Therefore, we're showing this block only if nvm has been loaded
  if [[ -n "$NVM_LAZY_LOAD" ]] && $(type node | grep -q 'shell function'); then
    return
  fi

  [[ -f "$(pwd)/package.json" || -d "$(pwd)/node_modules" || -n *.(js|jsx|ts|tsx)(#qN^/) ]] \
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
