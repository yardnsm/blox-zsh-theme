# ---------------------------------------------
# Configurations

# Defualts
__BLOX_SEG_DEFAULT__UPPER_LEFT=(host cwd git)
__BLOX_SEG_DEFAULT__UPPER_RIGHT=(bgjobs nodejs time)
__BLOX_SEG_DEFAULT__LOWER_LEFT=(symbol)
__BLOX_SEG_DEFAULT__LOWER_RIGHT=( )

# Upper
BLOX_SEG__UPPER_LEFT=${BLOX_SEG__UPPER_LEFT:-$__BLOX_SEG_DEFAULT__UPPER_LEFT}
BLOX_SEG__UPPER_RIGHT=${BLOX_SEG__UPPER_RIGHT:-$__BLOX_SEG_DEFAULT__UPPER_RIGHT}

# Lower
BLOX_SEG__LOWER_LEFT=${BLOX_SEG__LOWER_LEFT:-$__BLOX_SEG_DEFAULT__LOWER_LEFT}
BLOX_SEG__LOWER_RIGHT=${BLOX_SEG__LOWER_RIGHT:-$__BLOX_SEG_DEFAULT__LOWER_RIGHT}

# ---------------------------------------------
# Helper functions

# Build a given segment
function blox_helper__render_segment() {

  local blocks=(`echo $@`)
  local segment=""

  for block in ${blocks[@]}; do
    contents="$(blox_block__${block})"

    if [[ -n "$contents" ]]; then
      [[ -n "$segment" ]] \
        && segment+="$BLOX_CONF__BLOCK_SEPARATOR"

      segment+="$contents"
    fi
  done

  echo $segment
}
