-- KNEX & RAW Symbol Hammerspoon Module
-- Add this to your ~/.hammerspoon/init.lua
--
-- KNEX (₭) = main unit (like $)
-- RAW (ℛ)  = smallest unit (like ¢)
-- 1 KNEX = 10,000,000 RAW (10M)

local KNEX_SYMBOL = "\u{E000}"  -- Private Use Area U+E000
local RAW_SYMBOL = "\u{E001}"   -- Private Use Area U+E001
local KNEX_FALLBACK = "K"       -- Fallback if font missing
local RAW_FALLBACK = "r"        -- Fallback if font missing

-- ═══════════════════════════════════════════════════════════════
-- METHOD 1: Popup Chooser (for hold-K via Karabiner)
-- ═══════════════════════════════════════════════════════════════

local knexChooser = nil

local knexChoices = {
    {
        ["text"] = "₭  KNEX with space",
        ["subText"] = "Symbol followed by space (recommended)",
        ["symbol"] = KNEX_SYMBOL .. " "
    },
    {
        ["text"] = "₭ KNEX Symbol",
        ["subText"] = "Insert KNEX currency symbol (U+E000)",
        ["symbol"] = KNEX_SYMBOL
    },
    {
        ["text"] = "ℛ  RAW with space",
        ["subText"] = "RAW symbol (1 KNEX = 10M RAW)",
        ["symbol"] = RAW_SYMBOL .. " "
    },
    {
        ["text"] = "ℛ RAW Symbol",
        ["subText"] = "Insert RAW symbol (U+E001)",
        ["symbol"] = RAW_SYMBOL
    },
    {
        ["text"] = "₭12.46 Price format",
        ["subText"] = "KNEX with price placeholder",
        ["symbol"] = KNEX_SYMBOL .. "12.46"
    },
    {
        ["text"] = "ℛ124,600,000 RAW price",
        ["subText"] = "RAW equivalent of ₭12.46",
        ["symbol"] = RAW_SYMBOL .. "124,600,000"
    }
}

function showKnexChooser()
    if knexChooser == nil then
        knexChooser = hs.chooser.new(function(choice)
            if choice then
                hs.timer.doAfter(0.05, function()
                    hs.eventtap.keyStrokes(choice.symbol)
                end)
            end
        end)

        knexChooser:choices(knexChoices)
        knexChooser:placeholderText("Choose KNEX/RAW symbol...")
        knexChooser:searchSubText(true)
        knexChooser:bgDark(true)
    end

    knexChooser:show()
end

-- Make globally accessible for Karabiner shell command
_G.showKnexChooser = showKnexChooser

-- ═══════════════════════════════════════════════════════════════
-- METHOD 2: Direct Hotkeys
-- ═══════════════════════════════════════════════════════════════

-- KNEX SYMBOL (like $)
-- Option+K = symbol WITH space (default, most common use)
hs.hotkey.bind({"alt"}, "k", function()
    hs.eventtap.keyStrokes(KNEX_SYMBOL .. " ")
end)

-- Option+Shift+K = symbol WITHOUT space (for tight formatting)
hs.hotkey.bind({"alt", "shift"}, "k", function()
    hs.eventtap.keyStrokes(KNEX_SYMBOL)
end)

-- RAW SYMBOL (like ¢)
-- Option+R = symbol WITH space
hs.hotkey.bind({"alt"}, "r", function()
    hs.eventtap.keyStrokes(RAW_SYMBOL .. " ")
end)

-- Option+Shift+R = symbol WITHOUT space
hs.hotkey.bind({"alt", "shift"}, "r", function()
    hs.eventtap.keyStrokes(RAW_SYMBOL)
end)

-- ═══════════════════════════════════════════════════════════════
-- UTILITY: Copy symbols to clipboard
-- ═══════════════════════════════════════════════════════════════

-- Option+Ctrl+K = copy KNEX symbol
hs.hotkey.bind({"alt", "ctrl"}, "k", function()
    hs.pasteboard.setContents(KNEX_SYMBOL)
    hs.alert.show("KNEX symbol copied! " .. KNEX_SYMBOL)
end)

-- Option+Ctrl+R = copy RAW symbol
hs.hotkey.bind({"alt", "ctrl"}, "r", function()
    hs.pasteboard.setContents(RAW_SYMBOL)
    hs.alert.show("RAW symbol copied! " .. RAW_SYMBOL)
end)

-- ═══════════════════════════════════════════════════════════════
-- VISUAL FEEDBACK
-- ═══════════════════════════════════════════════════════════════

hs.alert.show("KnexCoin Keyboard Loaded ₭ ℛ")
print("══════════════════════════════════════════════════════")
print("  KNEXCOIN KEYBOARD MODULE LOADED")
print("══════════════════════════════════════════════════════")
print("")
print("  KNEX (like $):        RAW (like ¢):")
print("  ─────────────         ─────────────")
print("  Option+K     → ₭      Option+R     → ℛ ")
print("  Option+Shift+K → ₭    Option+Shift+R → ℛ")
print("  Option+Ctrl+K → copy  Option+Ctrl+R → copy")
print("")
print("  Hold K (300ms) → Show symbol chooser")
print("")
print("  1 KNEX = 10,000,000 RAW (10M)")
print("══════════════════════════════════════════════════════")
