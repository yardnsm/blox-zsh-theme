# ---------------------------------------------
# CWD block configurations

BLOX_BLOCK__CWD_COLOR="${BLOX_BLOCK__CWD_COLOR:-blue}"
BLOX_BLOCK__CWD_TRUNC="${BLOX_BLOCK__CWD_TRUNC:-3}"

# ---------------------------------------------

function blox_block__cwd() {
  local result=""

  result="%F{${BLOX_BLOCK__CWD_COLOR}}"
  result+="%($(( $BLOX_BLOCK__CWD_TRUNC + 1 ))~|.../%$BLOX_BLOCK__CWD_TRUNC~|%~)";
  result+="%{$reset_color%}"

  echo $result
}
