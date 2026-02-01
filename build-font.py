#!/usr/bin/env python3
"""
KnexCoin Font Builder
Creates a TTF font with:
  - KNEX symbol (₭) at U+E000 (like $)
  - RAW symbol (⋖) at U+E001 (like ¢)

1 ₭ = 10,000,000⋖ (10M RAW)

Requirements: FontForge (brew install fontforge)
Usage: fontforge -script build-font.py
"""

import fontforge
import os

# Configuration
FONT_NAME = "KnexSymbol"
FAMILY_NAME = "Knex Symbol"
FULL_NAME = "Knex Symbol Regular"
VERSION = "1.0"
COPYRIGHT = "KnexCoin 2026"

# Private Use Area codepoints
KNEX_CODEPOINT = 0xE000  # KNEX symbol (like $)
RAW_CODEPOINT = 0xE001   # RAW symbol (like ¢)

# Get script directory
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
KNEX_SVG = os.path.join(SCRIPT_DIR, "KnexSymbol-glyph.svg")
RAW_SVG = os.path.join(SCRIPT_DIR, "RawSymbol-glyph.svg")
OUTPUT_TTF = os.path.join(SCRIPT_DIR, "KnexSymbol.ttf")
OUTPUT_WOFF2 = os.path.join(SCRIPT_DIR, "KnexSymbol.woff2")

def create_knex_font():
    # Create new font
    font = fontforge.font()

    # Set font metadata
    font.fontname = FONT_NAME
    font.familyname = FAMILY_NAME
    font.fullname = FULL_NAME
    font.version = VERSION
    font.copyright = COPYRIGHT
    font.encoding = "UnicodeFull"

    # Set font metrics (standard 1000 UPM)
    font.em = 1000
    font.ascent = 800
    font.descent = 200

    # ═══════════════════════════════════════════════════════════════
    # KNEX SYMBOL (U+E000) - Like $ for dollars
    # ═══════════════════════════════════════════════════════════════
    knex_glyph = font.createChar(KNEX_CODEPOINT, "knexsymbol")

    if os.path.exists(KNEX_SVG):
        knex_glyph.importOutlines(KNEX_SVG)
        print(f"✓ Imported KNEX symbol from: {KNEX_SVG}")
    else:
        print(f"✗ KNEX SVG not found at {KNEX_SVG}")
        # Create placeholder K
        pen = knex_glyph.glyphPen()
        pen.moveTo((200, 0))
        pen.lineTo((300, 0))
        pen.lineTo((300, 700))
        pen.lineTo((200, 700))
        pen.closePath()
        pen.moveTo((300, 350))
        pen.lineTo((600, 700))
        pen.lineTo((700, 700))
        pen.lineTo((350, 350))
        pen.closePath()
        pen.moveTo((300, 350))
        pen.lineTo((350, 350))
        pen.lineTo((700, 0))
        pen.lineTo((600, 0))
        pen.closePath()
        pen = None

    knex_glyph.width = 1000
    knex_glyph.round()

    # ═══════════════════════════════════════════════════════════════
    # RAW SYMBOL (U+E001) - Like ¢ for cents
    # 1 KNEX = 10,000,000 RAW
    # ═══════════════════════════════════════════════════════════════
    raw_glyph = font.createChar(RAW_CODEPOINT, "rawsymbol")

    if os.path.exists(RAW_SVG):
        raw_glyph.importOutlines(RAW_SVG)
        print(f"✓ Imported RAW symbol from: {RAW_SVG}")
    else:
        print(f"✗ RAW SVG not found at {RAW_SVG}")
        # Create placeholder chevron with bar
        pen = raw_glyph.glyphPen()
        # Chevron <
        pen.moveTo((700, 200))
        pen.lineTo((300, 400))
        pen.lineTo((700, 600))
        pen.lineTo((700, 520))
        pen.lineTo((420, 400))
        pen.lineTo((700, 280))
        pen.closePath()
        # Vertical bar
        pen.moveTo((480, 150))
        pen.lineTo((560, 150))
        pen.lineTo((560, 650))
        pen.lineTo((480, 650))
        pen.closePath()
        pen = None

    raw_glyph.width = 1000
    raw_glyph.round()

    # ═══════════════════════════════════════════════════════════════
    # COPY TO LETTER KEYS FOR TESTING
    # ═══════════════════════════════════════════════════════════════

    # KNEX on 'K' and 'k'
    for char in ['K', 'k']:
        glyph = font.createChar(ord(char), char)
        font.selection.select(KNEX_CODEPOINT)
        font.copy()
        font.selection.select(ord(char))
        font.paste()
        glyph.width = 1000

    # RAW on 'R' and 'r'
    for char in ['R', 'r']:
        glyph = font.createChar(ord(char), char)
        font.selection.select(RAW_CODEPOINT)
        font.copy()
        font.selection.select(ord(char))
        font.paste()
        glyph.width = 1000

    # ═══════════════════════════════════════════════════════════════
    # .notdef GLYPH
    # ═══════════════════════════════════════════════════════════════
    notdef = font.createChar(-1, ".notdef")
    pen = notdef.glyphPen()
    pen.moveTo((100, 0))
    pen.lineTo((900, 0))
    pen.lineTo((900, 700))
    pen.lineTo((100, 700))
    pen.closePath()
    pen.moveTo((200, 100))
    pen.lineTo((200, 600))
    pen.lineTo((800, 600))
    pen.lineTo((800, 100))
    pen.closePath()
    pen = None
    notdef.width = 1000

    # ═══════════════════════════════════════════════════════════════
    # GENERATE FONT FILES
    # ═══════════════════════════════════════════════════════════════
    font.generate(OUTPUT_TTF)
    print(f"✓ Generated TTF: {OUTPUT_TTF}")

    try:
        font.generate(OUTPUT_WOFF2)
        print(f"✓ Generated WOFF2: {OUTPUT_WOFF2}")
    except Exception as e:
        print(f"⚠ WOFF2 skipped: {e}")

    # ═══════════════════════════════════════════════════════════════
    # SUMMARY
    # ═══════════════════════════════════════════════════════════════
    print("\n" + "="*60)
    print("   KNEXCOIN FONT CREATED SUCCESSFULLY")
    print("="*60)
    print(f"""
    Font: {FULL_NAME}

    SYMBOLS:
    ┌─────────┬──────────┬─────────────────────────────┐
    │ Symbol  │ Codepoint│ Shortcut                    │
    ├─────────┼──────────┼─────────────────────────────┤
    │ KNEX ₭  │ U+E000   │ Option+K (like $)           │
    │ RAW  ⋖  │ U+E001   │ Option+R (like ¢)           │
    └─────────┴──────────┴─────────────────────────────┘

    CONVERSION:
    1 ₭ = 10,000,000⋖ (10M RAW)

    USAGE:
    ₭ 12.46        = 12.46 KNEX
    124,600,000⋖   = 124.6M RAW = ₭ 12.46
    """)
    print("="*60)

    font.close()

if __name__ == "__main__":
    create_knex_font()
