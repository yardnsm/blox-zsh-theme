# ---------------------------------------------
# Configurations

# Defualts
__BLOX_SEG_DEFAULT__UPPER_LEFT=( host cwd git exec_time )
__BLOX_SEG_DEFAULT__UPPER_RIGHT=( bgjobs nodejs pyenv virtualenv time )
__BLOX_SEG_DEFAULT__LOWER_LEFT=( symbol )
__BLOX_SEG_DEFAULT__LOWER_RIGHT=( )

# Upper
BLOX_SEG__UPPER_LEFT=${BLOX_SEG__UPPER_LEFT:-$__BLOX_SEG_DEFAULT__UPPER_LEFT}
BLOX_SEG__UPPER_RIGHT=${BLOX_SEG__UPPER_RIGHT:-$__BLOX_SEG_DEFAULT__UPPER_RIGHT}

# Lower
BLOX_SEG__LOWER_LEFT=${BLOX_SEG__LOWER_LEFT:-$__BLOX_SEG_DEFAULT__LOWER_LEFT}
BLOX_SEG__LOWER_RIGHT=${BLOX_SEG__LOWER_RIGHT:-$__BLOX_SEG_DEFAULT__LOWER_RIGHT}

# ---------------------------------------------
# Helper functions

# Render a block
function blox_helper__render_block() {
  local block=$1
  local block_func="blox_block__${block}"

  if command -v "$block_func" &> /dev/null; then
    echo "$(${block_func})"
  else
    # Support for older versions of blox, where the block render function name
    # would be the same as the block name itself.
    echo $(${block})
  fi
}

# Build a given segment
function blox_helper__render_segment() {

  # For some reason, arrays cannot be assigned in typeset expressions in older versions of zsh.
  local blocks; blocks=( `echo $@` )
  local segment=""

  for block in ${blocks[@]}; do
    contents="$(blox_helper__render_block ${block})"

    if [[ -n "$contents" ]]; then
      [[ -n "$segment" ]] \
        && segment+="$BLOX_CONF__BLOCK_SEPARATOR"

      segment+="$contents"
    fi
  done

  echo $segment
}
