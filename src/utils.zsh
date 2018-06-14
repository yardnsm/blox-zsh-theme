# ---------------------------------------------
# Helper functions

# Check if command exists
function blox_util__exists() {
  command -v "$1" &> /dev/null
}

# Build a "common" block
function blox_util__build_block() {
  local -r color="$1"
  local -r contents="$2"

  local result=""

  result+="%F{${color}}"
  result+="${BLOX_CONF__BLOCK_PREFIX}${contents}${BLOX_CONF__BLOCK_SUFFIX}";
  result+="%{$reset_color%}"

  echo -n "$result"
}
