<!-- ocr-expediente:inicio -->
## OCR de PDF escaneados (obligatorio para cualquier agente)

Hay una herramienta local de OCR: `ocr-expediente` (usa Tesseract en esta máquina; nada se envía a internet).

### Entorno (dónde está y qué hacer si falla)
- Comando: `~/.local/bin/ocr-expediente` (instalado por `install.sh`). Si el shell no lo encuentra, prueba con la ruta completa.
- Repositorio: github.com/mariotrejo90/conversion-pdf-ocr (clon local esperado: `~/conversion-pdf-ocr`). Contiene el script `ocr-expediente`, `install.sh` y estas reglas.
- Dependencias: `ocrmypdf`, `tesseract` con el idioma `spa` y `poppler` (`pdftotext`, `pdfinfo`). En macOS suelen estar en `/opt/homebrew/bin`; si no aparecen, ejecuta antes `export PATH="/opt/homebrew/bin:/usr/local/bin:$HOME/.local/bin:$PATH"`.
- Comprobación rápida: `ocr-expediente --help`, `command -v ocrmypdf tesseract pdftotext` y `tesseract --list-langs` (debe incluir `spa`).
- Si falta algo, **no instales ni cambies software por tu cuenta**: dile al usuario qué falta y propón el comando:
  - Dependencias: `brew install ocrmypdf tesseract-lang poppler`
  - Comando ausente o desactualizado: `cd ~/conversion-pdf-ocr && git pull && bash install.sh`
- Los resultados (`NOMBRE.txt` y `NOMBRE_ocr.pdf`) quedan junto al PDF original, salvo que se indique otra carpeta con `-o`.

### Flujo
1. **Nunca leas un PDF escaneado como imagen, página por página, ni tomes capturas de pantalla para leerlo.**
2. Ante cualquier PDF que haya que leer, ejecuta primero `ocr-expediente ocr RUTA/archivo.pdf` (acepta carpetas). Imprime una línea por archivo (OK / OMITIDO / FALLO) con páginas, caracteres y "pág. con poco texto". OMITIDO = ya estaba procesado: úsalo.
3. Trabaja sobre el `.txt` resultante, con marcas `=== Folio N ===`:
   - `ocr-expediente buscar archivo.txt "término"` → folio y línea de cada coincidencia.
   - `ocr-expediente folio archivo.txt 12-15` → solo esos folios.
   - `ocr-expediente comparar A.txt B.txt` → solo las diferencias entre dos versiones.
4. No modifiques ni sobrescribas el PDF original.

### Precisión (prevalece sobre el ahorro de lecturas)
5. **Ante cualquier duda no adivines: amplía la lectura hasta resolverla.** Escalera:
   a) lee los folios vecinos y busca otras menciones del mismo dato (`folio`, `buscar`);
   b) mira la imagen de esa página, solo esa;
   c) reintenta el OCR de esa página con mayor resolución (por ejemplo `ocrmypdf --oversample 300`), sin tocar el original;
   d) si sigue sin resolverse, márcalo (punto 7).
6. **Datos críticos** (nombres, número de expediente o causa, fechas, plazos, cifras, montos, DUI, artículos y leyes citados): verifícalos siempre contra la imagen antes de usarlos en un texto formal o de citarlos literalmente, aunque el OCR parezca limpio.
7. **Lo que no se pueda leer se marca, no se completa:** `[ilegible]` si no se distingue; `[dudoso: lectura probable "…"]` si hay una lectura posible. Siempre con su folio. Nunca lo presentes como cita literal.
8. **Cobertura:** si la tarea exige concluir algo del expediente (cronología, plazos, prueba, estado del caso), lee completos los folios pertinentes con su contexto; no concluyas solo con coincidencias sueltas de una búsqueda. El ahorro de lectura nunca va a costa de la precisión.
9. Si `ocr-expediente` imprime FALLO, o una página figura con poco texto, trátala como **no leída** hasta resolverla; informa el motivo y no inventes su contenido.
10. **Al terminar entrega siempre un INFORME DE LECTURA:** folios leídos completos / solo parcialmente / no leídos; pasajes `[ilegible]` o `[dudoso]` con folio y motivo; qué hiciste para resolver cada duda; y qué necesitas del usuario (por ejemplo, la imagen de la página 14 o el original). Si algo no se leyó, dilo expresamente; nunca insinúes que se leyó.
<!-- ocr-expediente:fin -->
