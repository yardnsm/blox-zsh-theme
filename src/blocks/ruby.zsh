# --------------------------------------------- #
# | Block options
# --------------------------------------------- #
BLOX_BLOCK__RUBY_SYMBOL="${BLOX_BLOCK__RUBY_SYMBOL:-♢}"
BLOX_BLOCK__RUBY_COLOR="${BLOX_BLOCK__RUBY_COLOR:-red}"

# --------------------------------------------- #
# | The block itself
# --------------------------------------------- #
function blox_block__ruby() {

  [[ ! -f "$(pwd)/Gemfile" ]] && return
  local ruby_version=$(ruby --version | awk '{print $2}' | awk -F'p' '{print $1}')

  # The result
  res=""

  # Build the block
  if [[ ! -z "${ruby_version}" ]]; then
    res+="%{$fg[${BLOX_BLOCK__RUBY_COLOR}]%}"
    res+="${BLOX_CONF__BLOCK_PREFIX}${BLOX_BLOCK__RUBY_SYMBOL} ${ruby_version}${BLOX_CONF__BLOCK_SUFFIX}";
    res+="%{$reset_color%}"
  fi

  # Echo the block
  echo $res
}
