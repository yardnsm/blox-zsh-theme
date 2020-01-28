# ---------------------------------------------
# Host info block configurations

# User
BLOX_BLOCK__HOST_USER_SHOW_ALWAYS="${BLOX_BLOCK__HOST_USER_SHOW_ALWAYS:-false}"
BLOX_BLOCK__HOST_USER_COLOR="${BLOX_BLOCK__HOST_USER_COLOR:-yellow}"
BLOX_BLOCK__HOST_USER_ROOT_COLOR="${BLOX_BLOCK__HOST_USER_ROOT_COLOR:-red}"

# Machine
BLOX_BLOCK__HOST_MACHINE_SHOW_ALWAYS="${BLOX_BLOCK__HOST_MACHINE_SHOW_ALWAYS:-false}"
BLOX_BLOCK__HOST_MACHINE_COLOR="${BLOX_BLOCK__HOST_MACHINE_COLOR:-cyan}"

# ---------------------------------------------

function blox_block__host() {
  local user_color=$BLOX_BLOCK__HOST_USER_COLOR

  [[ $USER == "root" ]] \
    && user_color=$BLOX_BLOCK__HOST_USER_ROOT_COLOR

  local result=""

  # Check if the user info is needed
  if [[ $BLOX_BLOCK__HOST_USER_SHOW_ALWAYS != false ]] || [[ $(whoami | awk '{print $1}') != $USER ]]; then
    result+="%F{$user_color]%}%n%f"
  fi

  # Check if the machine name is needed
  if [[ $BLOX_BLOCK__HOST_MACHINE_SHOW_ALWAYS != false ]] || [[ -n $SSH_CONNECTION ]]; then

    [[ $result != "" ]] \
      && result+="@"

    result+="%F{${BLOX_BLOCK__HOST_MACHINE_COLOR}]%}%m%f"
  fi

  if [[ $result != "" ]]; then
    echo "$result:"
  fi
}
