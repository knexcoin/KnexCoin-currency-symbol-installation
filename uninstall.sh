#!/bin/bash
#
# KnexCoin Currency Symbols - Uninstall Script
# Run with: bash uninstall.sh
#

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo ""
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║       ₭ KNEXCOIN CURRENCY SYMBOLS - UNINSTALLER           ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""

# ═══════════════════════════════════════════════════════════════
# Confirm uninstall
# ═══════════════════════════════════════════════════════════════
read -p "This will remove all KnexCoin keyboard components. Continue? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Uninstall cancelled."
    exit 0
fi

# ═══════════════════════════════════════════════════════════════
# Remove Font
# ═══════════════════════════════════════════════════════════════
echo ""
echo -e "${YELLOW}[1/4] Removing Font...${NC}"

if [ -f ~/Library/Fonts/KnexSymbol.ttf ]; then
    rm ~/Library/Fonts/KnexSymbol.ttf
    echo "  Removed ~/Library/Fonts/KnexSymbol.ttf"
else
    echo "  Font not found (already removed)"
fi

# ═══════════════════════════════════════════════════════════════
# Remove Keyboard Layout
# ═══════════════════════════════════════════════════════════════
echo ""
echo -e "${YELLOW}[2/4] Removing Keyboard Layout...${NC}"

if [ -f ~/Library/Keyboard\ Layouts/KnexSymbol.keylayout ]; then
    rm ~/Library/Keyboard\ Layouts/KnexSymbol.keylayout
    echo "  Removed ~/Library/Keyboard Layouts/KnexSymbol.keylayout"
else
    echo "  Keyboard layout not found (already removed)"
fi

# ═══════════════════════════════════════════════════════════════
# Remove Hammerspoon Config
# ═══════════════════════════════════════════════════════════════
echo ""
echo -e "${YELLOW}[3/4] Removing Hammerspoon Configuration...${NC}"

if [ -f ~/.hammerspoon/init.lua ]; then
    if grep -q "KNEX.*Symbol Hammerspoon Module" ~/.hammerspoon/init.lua; then
        # Create backup
        cp ~/.hammerspoon/init.lua ~/.hammerspoon/init.lua.backup
        echo "  Created backup at ~/.hammerspoon/init.lua.backup"

        # Remove KNEX section (everything from the module comment to the last print)
        sed -i '' '/-- KNEX.*Symbol Hammerspoon Module/,/═══════════════════════════════════════════════════════════════$/d' ~/.hammerspoon/init.lua 2>/dev/null || {
            echo -e "  ${YELLOW}Could not automatically remove KNEX config.${NC}"
            echo "  Please manually edit ~/.hammerspoon/init.lua"
            echo "  Remove everything between '-- KNEX' and the end of the KNEX section"
        }
        echo "  Removed KNEX module from Hammerspoon config"
    else
        echo "  KNEX module not found in Hammerspoon config"
    fi
else
    echo "  Hammerspoon config not found"
fi

# ═══════════════════════════════════════════════════════════════
# Remove Karabiner Config
# ═══════════════════════════════════════════════════════════════
echo ""
echo -e "${YELLOW}[4/4] Removing Karabiner Configuration...${NC}"

if [ -f ~/.config/karabiner/assets/complex_modifications/karabiner-knex.json ]; then
    rm ~/.config/karabiner/assets/complex_modifications/karabiner-knex.json
    echo "  Removed Karabiner complex modification"
else
    echo "  Karabiner config not found (already removed)"
fi

# ═══════════════════════════════════════════════════════════════
# Cleanup
# ═══════════════════════════════════════════════════════════════
echo ""
echo -e "${GREEN}╔═══════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║                 UNINSTALL COMPLETE!                       ║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "Remaining steps:"
echo "  1. Log out and back in to refresh keyboard layouts"
echo "  2. Reload Hammerspoon (click menu bar icon → Reload Config)"
echo "  3. Optionally uninstall Hammerspoon/Karabiner via Homebrew:"
echo "     brew uninstall --cask hammerspoon"
echo "     brew uninstall --cask karabiner-elements"
echo ""
echo "Thank you for trying KnexCoin!"
echo ""
