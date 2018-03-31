# ---------------------------------------------
# Hooks

# Set the title to cwd
function blox_hook__title() {
  tab_label=${PWD/${HOME}/\~}
  echo -ne "\e]2;${tab_label}\a"
}
