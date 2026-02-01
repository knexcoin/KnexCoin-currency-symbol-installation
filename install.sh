#!/bin/bash
#
# KNEX Symbol - macOS Installation Script
# Run with: bash install.sh
#

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo ""
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║    ₭ KNEXCOIN CURRENCY SYMBOLS - macOS INSTALLER         ║"
echo "║           Type ₭ (KNEX) and ⋖ (RAW) anywhere!            ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""

# Check for Homebrew
if ! command -v brew &> /dev/null; then
    echo -e "${YELLOW}Homebrew not found. Installing...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# ═══════════════════════════════════════════════════════════════
# STEP 1: Build Font
# ═══════════════════════════════════════════════════════════════
echo ""
echo -e "${GREEN}[1/5] Building KNEX Symbol Font...${NC}"

if ! command -v fontforge &> /dev/null; then
    echo "Installing FontForge..."
    brew install fontforge
fi

cd "$SCRIPT_DIR"
if [ -f "build-font.py" ]; then
    fontforge -script build-font.py 2>/dev/null || {
        echo -e "${YELLOW}FontForge script had warnings (this is usually OK)${NC}"
    }
fi

# ═══════════════════════════════════════════════════════════════
# STEP 2: Install Font
# ═══════════════════════════════════════════════════════════════
echo ""
echo -e "${GREEN}[2/5] Installing Font...${NC}"

if [ -f "KnexSymbol.ttf" ]; then
    cp KnexSymbol.ttf ~/Library/Fonts/
    echo "Font installed to ~/Library/Fonts/KnexSymbol.ttf"
else
    echo -e "${RED}Font file not found. Creating manually...${NC}"
fi

# ═══════════════════════════════════════════════════════════════
# STEP 3: Install Keyboard Layout
# ═══════════════════════════════════════════════════════════════
echo ""
echo -e "${GREEN}[3/5] Installing Keyboard Layout...${NC}"

mkdir -p ~/Library/Keyboard\ Layouts
cp KnexSymbol.keylayout ~/Library/Keyboard\ Layouts/
echo "Keyboard layout installed. You'll need to:"
echo "  1. Open System Settings → Keyboard → Input Sources"
echo "  2. Click (+) and add 'Knex Symbol'"

# ═══════════════════════════════════════════════════════════════
# STEP 4: Install Hammerspoon
# ═══════════════════════════════════════════════════════════════
echo ""
echo -e "${GREEN}[4/5] Setting up Hammerspoon...${NC}"

if ! [ -d "/Applications/Hammerspoon.app" ]; then
    echo "Installing Hammerspoon..."
    brew install --cask hammerspoon
fi

mkdir -p ~/.hammerspoon

if [ -f ~/.hammerspoon/init.lua ]; then
    if ! grep -q "KNEX Symbol Hammerspoon Module" ~/.hammerspoon/init.lua; then
        echo "" >> ~/.hammerspoon/init.lua
        echo "-- KNEX Symbol Integration" >> ~/.hammerspoon/init.lua
        cat knex-hammerspoon.lua >> ~/.hammerspoon/init.lua
        echo "Added KNEX module to existing Hammerspoon config"
    else
        echo "KNEX module already in Hammerspoon config"
    fi
else
    cp knex-hammerspoon.lua ~/.hammerspoon/init.lua
    echo "Created new Hammerspoon config with KNEX module"
fi

# ═══════════════════════════════════════════════════════════════
# STEP 5: Install Karabiner (optional)
# ═══════════════════════════════════════════════════════════════
echo ""
echo -e "${GREEN}[5/5] Setting up Karabiner-Elements (for press-and-hold)...${NC}"

read -p "Install Karabiner-Elements for press-and-hold K popup? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if ! [ -d "/Applications/Karabiner-Elements.app" ]; then
        brew install --cask karabiner-elements
    fi

    mkdir -p ~/.config/karabiner/assets/complex_modifications
    cp karabiner-knex.json ~/.config/karabiner/assets/complex_modifications/
    echo "Karabiner rule installed. Enable it in Karabiner-Elements → Complex Modifications"
else
    echo "Skipping Karabiner installation"
fi

# ═══════════════════════════════════════════════════════════════
# DONE
# ═══════════════════════════════════════════════════════════════
echo ""
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║                 INSTALLATION COMPLETE!                    ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""
echo "Next steps:"
echo "  1. Log out and back in (or run: killall SystemUIServer)"
echo "  2. Add 'Knex Symbol' keyboard in System Settings"
echo "  3. Open Hammerspoon and grant Accessibility permissions"
echo "  4. Test: Press Option+K to type the KNEX symbol"
echo ""
echo "Keyboard shortcuts:"
echo ""
echo "  KNEX (₭):                      RAW (⋖):"
echo "  ─────────────────────          ─────────────────────"
echo "  • Option+K     → ₭ + space     • Option+R     → ⋖ + space"
echo "  • Option+Shift+K → ₭           • Option+Shift+R → ⋖"
echo "  • Option+Ctrl+K  → copy        • Option+Ctrl+R  → copy"
echo ""
echo "  Hold K (300ms) → Show chooser (if Karabiner enabled)"
echo ""
echo "  Currency: 1 ₭ = 10,000,000 ⋖ (10M RAW)"
echo ""
echo -e "${GREEN}Happy KNEXing! ₭ ⋖${NC}"
