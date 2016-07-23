#!/usr/bin/env bash

# --------------------------------------------- #
# | Concate everything into one file
# --------------------------------------------- #

echo ""
echo "  Building Blox"
echo "  =============================="
echo ""

cat src/banner.txt src/blocks/*.zsh src/main.zsh > blox.zsh

echo "  DONE. Check 'blox.zsh' file."
