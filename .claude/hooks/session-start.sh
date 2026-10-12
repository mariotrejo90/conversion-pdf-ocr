#!/bin/bash
# Prepara las sesiones en la nube: Tesseract (español), poppler, OCRmyPDF y el comando ocr-expediente.
# Solo corre en entornos remotos; es idempotente.
set -euo pipefail

if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

REPO="${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "$0")/../.." && pwd)}"
VENV="$HOME/.venvs/ocr"
BIN="$HOME/.local/bin"

faltan=""
command -v tesseract >/dev/null 2>&1 || faltan="$faltan tesseract-ocr"
tesseract --list-langs 2>/dev/null | grep -qx spa || faltan="$faltan tesseract-ocr-spa"
command -v pdftotext >/dev/null 2>&1 || faltan="$faltan poppler-utils"
command -v gs >/dev/null 2>&1 || faltan="$faltan ghostscript"
command -v convert >/dev/null 2>&1 || faltan="$faltan imagemagick"
if [ -n "$faltan" ]; then
  (apt-get install -y -q $faltan >/dev/null 2>&1) || (apt-get update -q >/dev/null 2>&1 && apt-get install -y -q $faltan >/dev/null)
fi

# OCRmyPDF en entorno virtual (el paquete de apt trae un pikepdf que falla en este contenedor)
if [ ! -x "$VENV/bin/ocrmypdf" ]; then
  python3 -m venv "$VENV"
  "$VENV/bin/pip" install -q ocrmypdf
fi

mkdir -p "$BIN"
ln -sf "$REPO/ocr-expediente" "$BIN/ocr-expediente"
chmod +x "$REPO/ocr-expediente"

if [ -n "${CLAUDE_ENV_FILE:-}" ]; then
  echo "export PATH=\"$VENV/bin:$BIN:\$PATH\"" >> "$CLAUDE_ENV_FILE"
fi
