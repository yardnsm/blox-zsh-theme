# ---------------------------------------------
# Utilities functions

# Check if command exists
function blox_util__exists() {
  command -v "$1" &> /dev/null
}

# Build a "common" block
function blox_util__build_block() {
  local -r color="$1"
  local -r contents="$2"
  local -r prefix="${3:-$BLOX_CONF__BLOCK_PREFIX}"
  local -r suffix="${4:-$BLOX_CONF__BLOCK_SUFFIX}"

  local result=""

  result+="%F{${color}}"
  result+="${prefix}${contents}${suffix}";
  result+="%{$reset_color%}"

  echo -n "$result"
}
