#!/usr/bin/env bash
# Prueba de humo: crea un PDF "escaneado" (solo imagen), le hace OCR y verifica el resultado.
set -euo pipefail
AQUI="$(cd "$(dirname "$0")/.." && pwd)"
T="$(mktemp -d)"
convert -size 1240x1754 xc:white -font DejaVu-Sans -pointsize 34 -fill black \
  -annotate +80+150 "SENTENCIA\nSe ordena la detención provisional\nde acuerdo al artículo 329 CPP." "$T/p.png"
convert "$T/p.png" -density 150 "$T/doc.pdf"
ANTES="$(cksum < "$T/doc.pdf")"
"$AQUI/ocr-expediente" ocr "$T/doc.pdf"
[ "$ANTES" = "$(cksum < "$T/doc.pdf")" ] || { echo "ERROR: el original cambió"; exit 1; }
"$AQUI/ocr-expediente" buscar "$T/doc.txt" "artículo" | grep -q "Folio 1"
echo "PRUEBA DE HUMO OK"
