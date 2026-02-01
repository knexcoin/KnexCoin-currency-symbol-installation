# ₭ Special KnexCoin Currency Integration

<p align="center">
  <img src="assets/knex-banner.svg" alt="KnexCoin Currency Symbols" width="600"/>
</p>

<p align="center">
  <strong>Type ₭ (KNEX) and ⋖ (RAW) currency symbols anywhere!</strong>
  <br/>
  <em>macOS • Windows • Linux</em>
</p>

<p align="center">
  <a href="#-quick-install">Quick Install</a> •
  <a href="#-keyboard-shortcuts">Shortcuts</a> •
  <a href="#-currency-system">Currency System</a> •
  <a href="#-troubleshooting">Troubleshooting</a>
</p>

---

## 💰 Currency System

```
┌─────────────────────────────────────────────────────────────┐
│                    KNEXCOIN CURRENCY                        │
├──────────┬───────────┬──────────┬──────────────────────────┤
│ Symbol   │ Unicode   │ Shortcut │ Equivalent               │
├──────────┼───────────┼──────────┼──────────────────────────┤
│ ₭ KNEX   │ U+20AD    │ ⌥K       │ Like $ (dollar)          │
│ ⋖ RAW    │ U+22D6    │ ⌥R       │ Like ¢ (cent)            │
└──────────┴───────────┴──────────┴──────────────────────────┘

                1 ₭ = 10,000,000 ⋖ (10M RAW)
```

### Usage Examples

```
₭ 12.46           →  12.46 KNEX
⋖ 124,600,000     →  124.6M RAW  =  ₭ 12.46

Coffee:  ₭ 0.50   →  5,000,000 RAW
Tip:     ⋖ 500000 →  500K RAW = ₭ 0.05
```

---

## 🚀 Quick Install

### macOS

```bash
curl -fsSL https://raw.githubusercontent.com/knexcoin/KnexCoin-currency-symbol-installation/main/install.sh | bash
```

### Windows

```powershell
# Download and run in PowerShell (as Administrator)
irm https://raw.githubusercontent.com/knexcoin/KnexCoin-currency-symbol-installation/main/install.ps1 | iex
```

Or manually:
1. Download the repository
2. Right-click `install.ps1` → "Run with PowerShell"
3. Install [AutoHotkey](https://www.autohotkey.com/download/) if prompted

### Linux

```bash
curl -fsSL https://raw.githubusercontent.com/knexcoin/KnexCoin-currency-symbol-installation/main/install-linux.sh | bash
```

### Manual Install (All Platforms)

```bash
git clone https://github.com/knexcoin/KnexCoin-currency-symbol-installation.git
cd KnexCoin-currency-symbol-installation

# macOS
bash install.sh

# Linux
bash install-linux.sh

# Windows (PowerShell)
powershell -ExecutionPolicy Bypass -File install.ps1
```

---

## ⌨️ Keyboard Shortcuts

Once installed, use these shortcuts anywhere:

### macOS

| Shortcut | Output | Description |
|----------|--------|-------------|
| **⌥K** | `₭ ` | KNEX symbol + space |
| **⌥⇧K** | `₭` | KNEX symbol (no space) |
| **⌥R** | `⋖ ` | RAW symbol + space |
| **⌥⇧R** | `⋖` | RAW symbol (no space) |
| **⌥⌃K** | — | Copy KNEX to clipboard |
| **⌥⌃R** | — | Copy RAW to clipboard |

> **Legend:** ⌥ = Option, ⇧ = Shift, ⌃ = Control

### Windows

| Shortcut | Output | Description |
|----------|--------|-------------|
| **Alt+K** | `₭ ` | KNEX symbol + space |
| **Alt+Shift+K** | `₭` | KNEX symbol (no space) |
| **Alt+R** | `⋖ ` | RAW symbol + space |
| **Alt+Shift+R** | `⋖` | RAW symbol (no space) |
| **Alt+Ctrl+K** | — | Copy KNEX to clipboard |
| **Alt+Ctrl+R** | — | Copy RAW to clipboard |

> Requires [AutoHotkey](https://www.autohotkey.com/) (installed automatically)

### Linux

| Method | Sequence | Output |
|--------|----------|--------|
| **XCompose** | Compose → k → k | `₭` |
| **XCompose** | Compose → r → r | `⋖` |
| **Custom** | Super+K | `₭ ` |
| **Custom** | Super+R | `⋖ ` |

> Set your Compose key in System Settings → Keyboard. Custom shortcuts require `xdotool`.

---

## 📦 What Gets Installed

| Component | Location | Purpose |
|-----------|----------|---------|
| **KnexSymbol.ttf** | `~/Library/Fonts/` | Custom font with ₭ and ⋖ glyphs |
| **KnexSymbol.keylayout** | `~/Library/Keyboard Layouts/` | macOS keyboard layout |
| **Hammerspoon config** | `~/.hammerspoon/init.lua` | Hotkey bindings |

### Optional Components

| Component | Purpose |
|-----------|---------|
| **Karabiner-Elements** | Press-and-hold K popup selector |

---

## 📋 Requirements

### macOS
- macOS 10.15 (Catalina) or later
- Homebrew (installed automatically)
- Hammerspoon (installed automatically)

### Windows
- Windows 10 or later
- [AutoHotkey](https://www.autohotkey.com/) v1.1+ or v2 (prompted to install)
- PowerShell 5.0+

### Linux
- Any modern Linux distribution
- X11 or Wayland (XCompose for X11)
- Optional: `xdotool`, `xclip` for hotkey scripts

---

## 📖 Detailed Installation Guide

### Step 1: Run the Installer

```bash
bash install.sh
```

The installer will:
1. ✅ Install Homebrew (if needed)
2. ✅ Install FontForge and build the font
3. ✅ Install the KnexSymbol font
4. ✅ Install the keyboard layout
5. ✅ Install and configure Hammerspoon
6. ❓ Optionally install Karabiner-Elements

### Step 2: Grant Permissions

After installation, you **must** grant **Accessibility** permissions to Hammerspoon:

1. **System Settings** → **Privacy & Security** → **Accessibility**
2. Find **Hammerspoon** in the list
3. Toggle it **ON** ✅

### Step 3: Add Keyboard Layout (Optional)

For the keyboard layout method:

1. **System Settings** → **Keyboard** → **Input Sources**
2. Click **(+)** to add a new input source
3. Search for **"Knex Symbol"**
4. Add it and select it from the menu bar

### Step 4: Test It!

Open any text field and try:

```
⌥K  →  ₭
⌥R  →  ⋖
```

---

## 🎨 Symbol Design

### ₭ KNEX Symbol

The KNEX symbol is based on the **Kip sign** (₭, U+20AD), the currency symbol for the Laotian Kip. It resembles a **K with a horizontal bar**, perfectly representing KnexCoin.

```
    ██╗  ██╗
    ██║ ██╔╝
    █████╔╝     ₭
    ██╔═██╗
    ██║  ██╗
    ╚═╝  ╚═╝
```

### ⋖ RAW Symbol

The RAW symbol represents the smallest unit of KnexCoin. Our custom design features a **chevron with vertical stubs** - like the cents sign (¢) but pointing left to indicate smaller value.

**Custom SVG Design:**
```svg
<svg viewBox="0 0 256 256">
  <circle cx="128" cy="128" r="118" fill="#000"/>
  <g stroke="#FFF" stroke-width="22" stroke-linecap="round">
    <path d="M196 88 L60 128 L196 168"/>  <!-- chevron -->
    <path d="M128 64 L128 104"/>           <!-- top stub -->
    <path d="M128 152 L128 192"/>          <!-- bottom stub -->
  </g>
</svg>
```

For typing, we use **⋖** (U+22D6, less-than with dot) as the closest Unicode approximation.

---

## 🔧 Troubleshooting

### Symbol shows as box (□) or question mark (?)

**Cause:** The application doesn't support the Unicode character.

**Solution:** The installer uses universal Unicode symbols (₭ and ⋖) that work in most modern applications. If you see boxes, try a different font or application.

### ⌥K types something else (like ˚)

**Cause:** Hammerspoon doesn't have Accessibility permissions.

**Solution:**
1. Open **System Settings** → **Privacy & Security** → **Accessibility**
2. Enable **Hammerspoon** ✅
3. Click the Hammerspoon menu bar icon → **Reload Config**

### Hammerspoon not responding

```bash
# Restart Hammerspoon
killall Hammerspoon
open -a Hammerspoon
```

### Keyboard layout not appearing

```bash
# Refresh keyboard layouts
sudo killall SystemUIServer
```
Then log out and back in.

### Test if symbols work

```bash
# Copy KNEX symbol to clipboard
echo -n "₭" | pbcopy

# Copy RAW symbol to clipboard
echo -n "⋖" | pbcopy
```

---

## 🗑️ Uninstall

To completely remove the KnexCoin currency integration:

```bash
bash uninstall.sh
```

Or manually:

```bash
# Remove font
rm ~/Library/Fonts/KnexSymbol.ttf

# Remove keyboard layout
rm ~/Library/Keyboard\ Layouts/KnexSymbol.keylayout

# Edit Hammerspoon config to remove KNEX section
nano ~/.hammerspoon/init.lua
```

---

## 👩‍💻 For Developers

### Using in Web Projects

```css
/* CSS */
.price-knex::before {
  content: '₭ ';
}

.price-raw::before {
  content: '⋖ ';
}
```

```html
<!-- HTML -->
<span class="price-knex">12.46</span>
<span class="price-raw">124,600,000</span>
```

### Using in JavaScript

```javascript
const KNEX = '₭';
const RAW = '⋖';
const RAW_PER_KNEX = 10_000_000;

function formatKnex(amount) {
  return `${KNEX} ${amount.toFixed(2)}`;
}

function formatRaw(amount) {
  return `${RAW} ${amount.toLocaleString()}`;
}

function knexToRaw(knex) {
  return knex * RAW_PER_KNEX;
}

function rawToKnex(raw) {
  return raw / RAW_PER_KNEX;
}
```

### Building the Font

```bash
# Install FontForge
brew install fontforge

# Build font from SVG sources
fontforge -script build-font.py
```

---

## 📁 Repository Structure

```
KnexCoin-currency-symbol-installation/
├── README.md                 # This documentation
├── LICENSE                   # MIT License
│
├── install.sh                # macOS installer
├── install.ps1               # Windows installer (PowerShell)
├── install-linux.sh          # Linux installer
├── uninstall.sh              # macOS uninstaller
│
├── KnexSymbol.ttf            # TrueType font
├── KnexSymbol.woff2          # Web font
├── KnexSymbol.keylayout      # macOS keyboard layout
│
├── KnexSymbol-original.svg   # KNEX symbol source (256x256)
├── KnexSymbol-glyph.svg      # Font-ready KNEX glyph (1000 UPM)
├── RawSymbol-original.svg    # RAW symbol source (256x256)
├── RawSymbol-glyph.svg       # Font-ready RAW glyph (1000 UPM)
│
├── knex-hammerspoon.lua      # macOS Hammerspoon hotkey config
├── karabiner-knex.json       # macOS Karabiner complex modification
└── build-font.py             # FontForge build script
```

---

## 🤝 Contributing

1. Fork this repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📄 License

MIT License - see [LICENSE](LICENSE) for details.

---

## 🔗 Links

- **KnexCoin Website:** [https://knexcoin.org](https://knexcoin.org)
- **KnexWallet:** [https://github.com/knexcoin/KnexWallet](https://github.com/knexcoin/KnexWallet)
- **AyeDEX Exchange:** [https://ayedex.knexcoin.org](https://ayedex.knexcoin.org)

---

<p align="center">
  Made with 💚 for the KnexCoin community
</p>

<p align="center">
  <strong>1 ₭ = 10,000,000 ⋖</strong>
</p>
