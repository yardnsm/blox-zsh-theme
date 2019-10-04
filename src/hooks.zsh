# ---------------------------------------------
# Configurations

# Hooks to set up
__BLOX_HOOKS_TO_SETUP=( preexec precmd )

# ---------------------------------------------
# Helper functions

# Setup hooks for each block
function blox_helper__setup_hooks() {
  local used_blocks=(
    "${BLOX_SEG__UPPER_LEFT[@]}"
    "${BLOX_SEG__UPPER_RIGHT[@]}"
    "${BLOX_SEG__LOWER_LEFT[@]}"
    "${BLOX_SEG__LOWER_RIGHT[@]}"
  )

  for block in ${used_blocks[@]}; do
    for hook in ${__BLOX_HOOKS_TO_SETUP[@]}; do
      local current_hook_function="blox_block__${block}_hook__${hook}"

      # Check if the hook exists
      if typeset -f "$current_hook_function" &> /dev/null; then
        add-zsh-hook "$hook" "$current_hook_function"
      fi
    done
  done
}
