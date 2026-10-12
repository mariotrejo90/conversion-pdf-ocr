#!/usr/bin/env bash
# Instala `ocr-expediente` en ~/.local/bin y, si se pide, deja las reglas para agentes.
#   bash install.sh             -> instala el comando y revisa dependencias
#   bash install.sh --agentes   -> además agrega las reglas a ~/.claude/CLAUDE.md
set -e
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
AQUI="$(cd "$(dirname "$0")" && pwd)"
DEST="$HOME/.local/bin"

mkdir -p "$DEST"
cp "$AQUI/ocr-expediente" "$DEST/ocr-expediente"
chmod +x "$DEST/ocr-expediente"
echo "Instalado: $DEST/ocr-expediente"

# Que el comando se encuentre desde cualquier terminal (zsh en macOS)
if ! echo "$PATH" | tr ':' '\n' | grep -qx "$DEST"; then
  if ! grep -qs '\.local/bin' "$HOME/.zshrc"; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"
    echo "Agregado ~/.local/bin al PATH en ~/.zshrc (abra una Terminal nueva)."
  fi
fi

faltan=""
for p in ocrmypdf tesseract pdftotext pdfinfo; do command -v "$p" >/dev/null 2>&1 || faltan="$faltan $p"; done
if [ -n "$faltan" ]; then
  echo "Faltan:$faltan"
  echo "Instálelos con:  brew install ocrmypdf tesseract-lang poppler"
elif ! tesseract --list-langs 2>/dev/null | grep -qx spa; then
  echo "Tesseract no tiene español. Instálelo con:  brew install tesseract-lang"
else
  echo "Dependencias OK (ocrmypdf, tesseract con 'spa', poppler)."
fi

if [ "${1:-}" = "--agentes" ]; then
  CM="$HOME/.claude/CLAUDE.md"
  mkdir -p "$HOME/.claude"
  if grep -qs 'ocr-expediente:inicio' "$CM"; then
    echo "Las reglas ya estaban en $CM (no se duplican)."
  else
    { echo; cat "$AQUI/AGENTS.md"; } >> "$CM"
    echo "Reglas agregadas a $CM"
  fi
  echo "Para Hermes u otro agente: copie el contenido de AGENTS.md a su archivo de instrucciones."
fi
