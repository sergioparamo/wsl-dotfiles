#!/usr/bin/env bash
set -e

echo "✨ Importing jumpers to zoxide..."

# -----------------------------
# Autojump
# -----------------------------
AUTJUMP_PATH="${XDG_DATA_HOME:-$HOME/.local/share}/autojump/autojump.txt"
if [ -f "$AUTJUMP_PATH" ]; then
    echo "📥 Importing Autojump..."
    zoxide import --from=autojump "$AUTJUMP_PATH"
fi

# -----------------------------
# Fasd
# -----------------------------
FASD_PATH="${_FASD_DATA:-$HOME/.fasd}"
if [ -f "$FASD_PATH" ] || [ -d "$FASD_PATH" ]; then
    echo "📥 Importing Fasd..."
    zoxide import --from=fasd "$FASD_PATH"
fi

# -----------------------------
# z (bash/zsh)
# -----------------------------
Z_PATH="${_Z_DATA:-$HOME/.z}"
if [ -f "$Z_PATH" ] || [ -d "$Z_PATH" ]; then
    echo "📥 Importing z..."
    zoxide import --from=z "$Z_PATH"
fi

# -----------------------------
# z.lua
# -----------------------------
ZL_PATH="${_ZL_DATA:-${XDG_DATA_HOME:-$HOME/.local/share}/zlua/zlua.txt}"
if [ -f "$ZL_PATH" ]; then
    echo "📥 Importing z.lua..."
    zoxide import --from=z.lua "$ZL_PATH"
fi

# -----------------------------
# zsh-z
# -----------------------------
ZSHZ_PATH="${ZSHZ_DATA:-${_Z_DATA:-$HOME/.z}}"
if [ -f "$ZSHZ_PATH" ] || [ -d "$ZSHZ_PATH" ]; then
    echo "📥 Importing zsh-z..."
    zoxide import --from=zsh-z "$ZSHZ_PATH"
fi

echo "✅ Import complete! Your zoxide database is now up to date."
