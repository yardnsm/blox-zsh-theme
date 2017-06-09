# ---------------------------------------------
# CWD block

BLOX_BLOCK__CWD_COLOR="${BLOX_BLOCK__CWD_COLOR:-blue}"
BLOX_BLOCK__CWD_TRUNC="${BLOX_BLOCK__CWD_TRUNC:-3}"

# ---------------------------------------------

function blox_block__cwd() {
  res="%F{${BLOX_BLOCK__CWD_COLOR}}"
  res+="%${BLOX_BLOCK__CWD_TRUNC}~";
  res+="%{$reset_color%}"

  echo $res
}
