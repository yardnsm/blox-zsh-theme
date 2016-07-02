#!/usr/bin/env bash

# --------------------------------------------- #
# | Concate everything into one file
# --------------------------------------------- #

echo ""
echo "  Building Blox (haha)"
echo "  =============================="
echo ""

cat src/blocks/**/*.zsh src/blocks/*.zsh src/main.zsh > blox.zsh

echo "  DONE. Check 'blox.zsh' file."
