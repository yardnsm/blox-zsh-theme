# ---------------------------------------------
# Host info block

# User
BLOX_BLOCK__HOST_USER_SHOW_ALWAYS="${BLOX_BLOCK__HOST_USER_SHOW_ALWAYS:-false}"
BLOX_BLOCK__HOST_USER_COLOR="${BLOX_BLOCK__HOST_USER_COLOR:-yellow}"
BLOX_BLOCK__HOST_USER_ROOT_COLOR="${BLOX_BLOCK__HOST_USER_ROOT_COLOR:-red}"

# Machine
BLOX_BLOCK__HOST_MACHINE_SHOW_ALWAYS="${BLOX_BLOCK__HOST_MACHINE_SHOW_ALWAYS:-false}"
BLOX_BLOCK__HOST_MACHINE_COLOR="${BLOX_BLOCK__HOST_MACHINE_COLOR:-cyan}"

# ---------------------------------------------
# The block itself

function blox_block__host() {
  local user_color=$BLOX_BLOCK__HOST_USER_COLOR

  [[ $USER == "root" ]] \
    && user_color=$BLOX_BLOCK__HOST_USER_ROOT_COLOR

  local info=""

  # Check if the user info is needed
  if [[ $BLOX_BLOCK__HOST_USER_SHOW_ALWAYS == true ]] || [[ $(whoami | awk '{print $1}') != $USER ]]; then
    info+="%F{$user_color]%}%n%{$reset_color%}"
  fi

  # Check if the machine name is needed
  if [[ $BLOX_BLOCK__HOST_MACHINE_SHOW_ALWAYS == true ]] || [[ -n $SSH_CONNECTION ]]; then
    [[ $info != "" ]] && info+="@"
    info+="%F{${BLOX_BLOCK__HOST_MACHINE_COLOR}]%}%m%{$reset_color%}"
  fi

  if [[ $info != "" ]]; then
    echo "$info:"
  fi
}
