# ---------------------------------------------
# AWS Profile block configurations

BLOX_BLOCK__AWSPROFILE_COLOR="${BLOX_BLOCK__AWSPROFILE_COLOR:-172}"

# ---------------------------------------------

function blox_block__awsprofile() {
  [[ -n "$AWS_PROFILE" ]] \
    || return

  blox_helper__build_block \
    "${BLOX_BLOCK__AWSPROFILE_COLOR}" \
    "AWS:${AWS_PROFILE}"
}
