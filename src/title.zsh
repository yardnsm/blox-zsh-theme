# ---------------------------------------------
# Hooks

# Set the title to cwd
function blox_hook__title() {
  echo -ne "\e]2;${PWD/${HOME}/\~}\a"
}
