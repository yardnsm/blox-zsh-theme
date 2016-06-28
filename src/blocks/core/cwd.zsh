# --------------------------------------------- #
# | Block options
# --------------------------------------------- #
BLOX_CORE__CWD_COLOR="${BLOX_CORE__CWD_COLOR:-blue}"
BLOX_CORE__CWD_TRUNC="${BLOX_CORE__CWD_TRUNC:-3}"

# --------------------------------------------- #
# | The block itself
# --------------------------------------------- #
function blox_core__cwd() {

  # Final result
  res=""

  # Append those
  res+="%{$fg_bold[${BLOX_CORE__CWD_COLOR}]%}"
  res+="%${BLOX_CORE__CWD_TRUNC}~";
  res+="%{$reset_color%}"

  # Echo result
  echo $res
}
