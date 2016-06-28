# --------------------------------------------- #
# | Block options
# --------------------------------------------- #

# Clean
BLOX_BLOCK__GIT_CLEAN_COLOR="${BLOX_BLOCK__GIT_CLEAN_COLOR:-green}"
BLOX_BLOCK__GIT_CLEAN_SYMBOL="${BLOX_BLOCK__GIT_CLEAN_SYMBOL:-☀︎}"

# Dirty
BLOX_BLOCK__GIT_DIRTY_COLOR="${BLOX_BLOCK__GIT_DIRTY_COLOR:-red}"
BLOX_BLOCK__GIT_DIRTY_SYMBOL="${BLOX_BLOCK__GIT_DIRTY_SYMBOL:-☂}"

# Unpulled
BLOX_BLOCK__GIT_UNPULLED_COLOR="${BLOX_BLOCK__GIT_UNPULLED_COLOR:-red}"
BLOX_BLOCK__GIT_UNPULLED_SYMBOL="${BLOX_BLOCK__GIT_UNPULLED_SYMBOL:-✈︎}"

# Unpushed
BLOX_BLOCK__GIT_UNPUSHED_COLOR="${BLOX_BLOCK__GIT_UNPUSHED_COLOR:-blue}"
BLOX_BLOCK__GIT_UNPUSHED_SYMBOL="${BLOX_BLOCK__GIT_UNPUSHED_SYMBOL:-☁︎}"

# --------------------------------------------- #
# | Themes
# --------------------------------------------- #
BLOX_BLOCK__GIT_THEME_CLEAN="%{$fg[${BLOX_BLOCK__GIT_CLEAN_COLOR}]%}$BLOX_BLOCK__GIT_CLEAN_SYMBOL%{$reset_color%}"
BLOX_BLOCK__GIT_THEME_DIRTY="%{$fg[${BLOX_BLOCK__GIT_DIRTY_COLOR}]%}$BLOX_BLOCK__GIT_DIRTY_SYMBOL%{$reset_color%}"
BLOX_BLOCK__GIT_THEME_UNPULLED="%{$fg[${BLOX_BLOCK__GIT_UNPULLED_COLOR}]%}$BLOX_BLOCK__GIT_UNPULLED_SYMBOL%{$reset_color%}"
BLOX_BLOCK__GIT_THEME_UNPUSHED="%{$fg[${BLOX_BLOCK__GIT_UNPUSHED_COLOR}]%}$BLOX_BLOCK__GIT_UNPUSHED_SYMBOL%{$reset_color%}"

# --------------------------------------------- #
# | Helper functions
# --------------------------------------------- #

# Get commit hash
function blox_block__git_helper__commit() {
  echo $(command git rev-parse --short HEAD)
}

# Get the current branch
function blox_block__git_helper__branch() {
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
  echo "${ref#refs/heads/}";
}

# Checks if working tree is dirty
blox_block__git_helper__dirty() {

  if [[ -z "$(git status --porcelain --ignore-submodules)" ]]; then

    # Clean
    echo $BLOX_BLOCK__GIT_THEME_CLEAN
  else

    # Dirty
    echo $BLOX_BLOCK__GIT_THEME_DIRTY
  fi
}

# Check remote status (pull/push)
function git_remote_status() {

  local git_local=$(command git rev-parse @ 2> /dev/null)
  local git_remote=$(command git rev-parse @{u} 2> /dev/null)
  local git_base=$(command git merge-base @ @{u} 2> /dev/null)

  # First check that we have a remote
  if ! [[ ${git_remote} = "" ]]; then

    # Now do all that shit
    if [[ ${git_local} = ${git_remote} ]]; then
      echo ""
    elif [[ ${git_local} = ${git_base} ]]; then
      echo " $BLOX_BLOCK__GIT_THEME_UNPULLED"
    elif [[ ${git_remote} = ${git_base} ]]; then
      echo " $BLOX_BLOCK__GIT_THEME_UNPUSHED"
    else
      echo " $BLOX_BLOCK__GIT_THEME_UNPULLED $BLOX_BLOCK__GIT_THEME_UNPUSHED"
    fi
  fi
}

# --------------------------------------------- #
# | The block itself
# --------------------------------------------- #
function blox_block__git() {

  if git rev-parse --git-dir > /dev/null 2>&1; then

    local branch="%F{242}$(blox_block__git_helper__branch)%{$reset_color%}"
    local remote="$(git_remote_status)"
    local commit="%{$fg[magenta]%}[$(blox_block__git_helper__commit)]%{$reset_color%}"
    local dirtyclean="$(blox_block__git_helper__dirty)"

	  echo "${branch}${commit} ${dirtyclean}${remote}"
  fi
}
