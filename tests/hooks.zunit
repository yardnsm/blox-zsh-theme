#!/usr/bin/env zunit

@setup {
  autoload -U add-zsh-hook
  load ../src/hooks.zsh
}

@test 'Should setup hooks defined in segments' {

  #
  # Setup blocks
  #

  function blox_block__BothPreexecPrecmd_hook__preexec() {}
  function  blox_block__BothPreexecPrecmd_hook__precmd() {}

  function blox_block__OnlyPreexec_hook__preexec() {}
  function blox_block__OnlyPrecmd_hook__precmd() {}

  #
  # Setup config
  #

  BLOX_SEG__UPPER_LEFT=( BothPreexecPrecmd OnlyPreexec )
  BLOX_SEG__UPPER_RIGHT=( NonExistBlock )
  BLOX_SEG__LOWER_LEFT=( AnotherNonExistBlock )
  BLOX_SEG__LOWER_RIGHT=( OnlyPrecmd )

  #
  # Assertions
  #

  blox_helper__setup_hooks

  run add-zsh-hook -L precmd

  assert $output contains 'blox_block__BothPreexecPrecmd_hook__precmd'
  assert $output contains 'blox_block__OnlyPrecmd_hook__precmd'
  assert $output does_not_contain 'blox_block__NonExistBlock_hook__precmd'
  assert $output does_not_contain 'blox_block__AnotherNonExistBlock_hook__precmd'

  run add-zsh-hook -L preexec

  assert $output contains 'blox_block__BothPreexecPrecmd_hook__preexec'
  assert $output contains 'blox_block__OnlyPreexec_hook__preexec'
  assert $output does_not_contain 'blox_block__NonExistBlock_hook__preexec'
  assert $output does_not_contain 'blox_block__AnotherNonExistBlock_hook__preexec'
}
