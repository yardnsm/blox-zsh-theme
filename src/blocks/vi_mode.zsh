# ---------------------------------------------
# Vi mode block

BLOX_BLOCK__VI_MODE_NORMAL="${BLOX_BLOCK__VI_MODE_NORMAL:-NORMAL}"
BLOX_BLOCK__VI_MODE_COLOR="${BLOX_BLOCK__VI_MODE_COLOR:-yellow}"

# ---------------------------------------------

function blox_block__vi_mode() {
  local res

  result+="%F{${BLOX_BLOCK__VI_MODE_COLOR}}"
  result+="${BLOX_CONF__BLOCK_PREFIX}${BLOX_BLOCK__VI_MODE_NORMAL}${BLOX_CONF__BLOCK_SUFFIX}";
  result+="%{$reset_color%}"

  if bindkey | grep "vi-quoted-insert" &> /dev/null; then
    echo "${${KEYMAP/vicmd/$result}/(main|viins)/}"
  fi
}
