#!/bin/bash
#
# KNEX Symbol - Linux Installation Script
# Run with: bash install-linux.sh
#

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo ""
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║    ₭ KNEXCOIN CURRENCY SYMBOLS - Linux INSTALLER          ║"
echo "║           Type ₭ (KNEX) and ⋖ (RAW) anywhere!             ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""

# Detect desktop environment
DESKTOP_ENV=""
if [ "$XDG_CURRENT_DESKTOP" ]; then
    DESKTOP_ENV="$XDG_CURRENT_DESKTOP"
elif [ "$DESKTOP_SESSION" ]; then
    DESKTOP_ENV="$DESKTOP_SESSION"
fi

echo -e "${GREEN}Detected desktop environment: ${DESKTOP_ENV:-Unknown}${NC}"
echo ""

# ═══════════════════════════════════════════════════════════════
# STEP 1: Install Font
# ═══════════════════════════════════════════════════════════════
echo ""
echo -e "${GREEN}[1/3] Installing KNEX Symbol Font...${NC}"

mkdir -p ~/.local/share/fonts
cp "$SCRIPT_DIR/KnexSymbol.ttf" ~/.local/share/fonts/
fc-cache -f -v ~/.local/share/fonts/ 2>/dev/null || true
echo "Font installed to ~/.local/share/fonts/KnexSymbol.ttf"

# ═══════════════════════════════════════════════════════════════
# STEP 2: Install XCompose (Universal method)
# ═══════════════════════════════════════════════════════════════
echo ""
echo -e "${GREEN}[2/3] Setting up XCompose sequences...${NC}"

XCOMPOSE_FILE="$HOME/.XCompose"

# Backup existing file
if [ -f "$XCOMPOSE_FILE" ]; then
    cp "$XCOMPOSE_FILE" "$XCOMPOSE_FILE.backup"
    echo "Backed up existing .XCompose to .XCompose.backup"
fi

# Add KNEX compose sequences
cat >> "$XCOMPOSE_FILE" << 'EOF'

# KNEX Currency Symbol Sequences
# Usage: Press Compose key, then the sequence
# To set Compose key: System Settings → Keyboard → Compose Key
#
# Sequences:
#   Compose + k + n + x  → ₭ (KNEX)
#   Compose + r + a + w  → ⋖ (RAW)
#   Compose + k + k      → ₭ (quick KNEX)
#   Compose + r + r      → ⋖ (quick RAW)

<Multi_key> <k> <n> <x> : "₭"   U20AD  # KNEX symbol
<Multi_key> <r> <a> <w> : "⋖"   U22D6  # RAW symbol
<Multi_key> <k> <k>     : "₭"   U20AD  # Quick KNEX
<Multi_key> <r> <r>     : "⋖"   U22D6  # Quick RAW

EOF

echo "XCompose sequences added to ~/.XCompose"

# ═══════════════════════════════════════════════════════════════
# STEP 3: Install xdotool hotkeys (if available)
# ═══════════════════════════════════════════════════════════════
echo ""
echo -e "${GREEN}[3/3] Setting up keyboard shortcuts...${NC}"

# Create helper scripts
mkdir -p ~/.local/bin

cat > ~/.local/bin/knex-symbol << 'EOF'
#!/bin/bash
# Type KNEX symbol
xdotool type "₭ "
EOF
chmod +x ~/.local/bin/knex-symbol

cat > ~/.local/bin/raw-symbol << 'EOF'
#!/bin/bash
# Type RAW symbol
xdotool type "⋖ "
EOF
chmod +x ~/.local/bin/raw-symbol

cat > ~/.local/bin/knex-copy << 'EOF'
#!/bin/bash
# Copy KNEX symbol to clipboard
echo -n "₭" | xclip -selection clipboard
notify-send "KNEX Symbol" "₭ copied to clipboard" 2>/dev/null || true
EOF
chmod +x ~/.local/bin/knex-copy

cat > ~/.local/bin/raw-copy << 'EOF'
#!/bin/bash
# Copy RAW symbol to clipboard
echo -n "⋖" | xclip -selection clipboard
notify-send "RAW Symbol" "⋖ copied to clipboard" 2>/dev/null || true
EOF
chmod +x ~/.local/bin/raw-copy

echo "Helper scripts installed to ~/.local/bin/"

# Check for xdotool
if ! command -v xdotool &> /dev/null; then
    echo ""
    echo -e "${YELLOW}xdotool not found. Install it for keyboard shortcuts:${NC}"
    echo "  Ubuntu/Debian: sudo apt install xdotool xclip"
    echo "  Fedora:        sudo dnf install xdotool xclip"
    echo "  Arch:          sudo pacman -S xdotool xclip"
fi

# ═══════════════════════════════════════════════════════════════
# Desktop-specific instructions
# ═══════════════════════════════════════════════════════════════
echo ""
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║                 INSTALLATION COMPLETE!                    ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""
echo -e "${GREEN}Set up keyboard shortcuts in your desktop environment:${NC}"
echo ""

case "$DESKTOP_ENV" in
    *GNOME*|*gnome*|*ubuntu*)
        echo "GNOME/Ubuntu:"
        echo "  1. Open Settings → Keyboard → Custom Shortcuts"
        echo "  2. Add these shortcuts:"
        echo "     • Name: KNEX Symbol    Command: ~/.local/bin/knex-symbol    Key: Super+K"
        echo "     • Name: RAW Symbol     Command: ~/.local/bin/raw-symbol     Key: Super+R"
        echo "     • Name: Copy KNEX      Command: ~/.local/bin/knex-copy      Key: Super+Shift+K"
        echo "     • Name: Copy RAW       Command: ~/.local/bin/raw-copy       Key: Super+Shift+R"
        ;;
    *KDE*|*kde*|*plasma*)
        echo "KDE Plasma:"
        echo "  1. Open System Settings → Shortcuts → Custom Shortcuts"
        echo "  2. Add new shortcuts pointing to:"
        echo "     • ~/.local/bin/knex-symbol  (Meta+K)"
        echo "     • ~/.local/bin/raw-symbol   (Meta+R)"
        ;;
    *XFCE*|*xfce*)
        echo "XFCE:"
        echo "  1. Open Settings → Keyboard → Application Shortcuts"
        echo "  2. Add shortcuts for the scripts in ~/.local/bin/"
        ;;
    *)
        echo "Generic instructions:"
        echo "  Add keyboard shortcuts in your system settings pointing to:"
        echo "  • ~/.local/bin/knex-symbol  → Types ₭"
        echo "  • ~/.local/bin/raw-symbol   → Types ⋖"
        echo "  • ~/.local/bin/knex-copy    → Copies ₭"
        echo "  • ~/.local/bin/raw-copy     → Copies ⋖"
        ;;
esac

echo ""
echo "XCompose method (works everywhere):"
echo "  1. Set a Compose key in your keyboard settings"
echo "  2. Press: Compose → k → k  for ₭"
echo "  3. Press: Compose → r → r  for ⋖"
echo ""
echo "Currency: 1 ₭ = 10,000,000 ⋖ (10M RAW)"
echo ""
echo -e "${GREEN}Happy KNEXing! ₭ ⋖${NC}"
