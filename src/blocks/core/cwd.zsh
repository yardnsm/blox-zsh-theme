# --------------------------------------------- #
# | Block options
# --------------------------------------------- #
BLOX_BLOCK__CWD_COLOR="${BLOX_BLOCK__CWD_COLOR:-blue}"
BLOX_BLOCK__CWD_TRUNC="${BLOX_BLOCK__CWD_TRUNC:-3}"

# --------------------------------------------- #
# | The block itself
# --------------------------------------------- #
function blox_block__cwd() {

  # Final result
  res=""

  # Append those
  res+="%{$fg_bold[${BLOX_BLOCK__CWD_COLOR}]%}"
  res+="%${BLOX_BLOCK__CWD_TRUNC}~";
  res+="%{$reset_color%}"

  # Echo result
  echo $res
}
