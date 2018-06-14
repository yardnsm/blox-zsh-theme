# ---------------------------------------------
# Pyenv block

BLOX_BLOCK__PYENV_COLOR="${BLOX_BLOCK__PYENV_COLOR:-green}"

# ---------------------------------------------

function blox_block__pyenv_helper__get_version() {
  echo -n "$(pyenv version-name 2>/dev/null)"
}

function blox_block__pyenv() {
  [[ -n *.py(#qN^/) ]] \
    || return

  command -v "pyenv" &> /dev/null \
    || return

  local python_version=$(blox_block__pyenv_helper__get_version)
  local result=""

  if [[ ! -z "${python_version}" ]]; then
    result+="%F{${BLOX_BLOCK__PYENV_COLOR}}"
    result+="${BLOX_CONF__BLOCK_PREFIX}py:${python_version}${BLOX_CONF__BLOCK_SUFFIX}"
    result+="%{$reset_color%}"
  fi

  echo $result
}
