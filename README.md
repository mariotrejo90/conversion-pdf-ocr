# conversion-pdf-ocr

OCR local de PDF escaneados para que **cualquier agente de IA** (Claude Code, Hermes, etc.) lo ejecute solo, usando el Tesseract de su máquina. Nada se sube a internet y el agente lee texto en vez de imágenes.

## Instalación (una sola vez, en la Terminal del Mac)

```bash
brew install ocrmypdf tesseract-lang poppler   # si aún no los tiene
bash install.sh --agentes
```

- `install.sh` copia `ocr-expediente` a `~/.local/bin`.
- `--agentes` agrega las reglas de `AGENTS.md` a `~/.claude/CLAUDE.md`, para que Claude Code las siga en todos sus proyectos.
- Para Hermes u otro agente: pegue el contenido de `AGENTS.md` en su archivo de instrucciones. Verifique en su documentación cuál archivo lee.

Después no tiene que ejecutar nada: el agente llama a la herramienta.

## Qué hace

| Comando | Para qué |
|---|---|
| `ocr-expediente ocr ARCHIVO.pdf\|CARPETA` | OCR en español; deja `NOMBRE_ocr.pdf` y `NOMBRE.txt` (con `=== Folio N ===`). Una línea de salida por archivo. |
| `ocr-expediente buscar NOMBRE.txt "texto"` | Folio y línea de cada coincidencia. |
| `ocr-expediente folio NOMBRE.txt 12-15` | Solo esos folios. |
| `ocr-expediente comparar A.txt B.txt` | Solo las diferencias entre dos textos. |

Garantías:
- El PDF original nunca se modifica ni se sobrescribe.
- Si un archivo ya fue procesado, lo omite (`--forzar` para rehacerlo).
- Si no se obtiene texto, informa `FALLO` con el motivo; no declara éxito.
- Marca las páginas con poco texto (sellos, manuscritos, hojas en blanco) para que el agente revise solo esas.
- PDF firmados digitalmente o cifrados: no fuerza el OCR; usa el texto digital si lo hay.

## Advertencias

- El OCR se equivoca en nombres propios, números de expediente, fechas, cifras y artículos. Coteje contra la imagen antes de citar literalmente.
- La herramienta no impide que un agente con modelo externo reciba el **texto** que usted le pida analizar. Si el texto es de un expediente, el modelo que lo lea es quien lo recibe; ese es el punto donde se decide la reserva profesional.
