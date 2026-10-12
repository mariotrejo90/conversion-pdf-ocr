<!-- ocr-expediente:inicio -->
## OCR de PDF escaneados (obligatorio para cualquier agente)

Hay una herramienta local de OCR: `ocr-expediente` (usa Tesseract en esta máquina; nada se envía a internet).

Reglas:
1. **Nunca leas un PDF escaneado como imagen, página por página, ni tomes capturas de pantalla para leerlo.** Es lo más caro y lo menos preciso.
2. Ante cualquier PDF que haya que leer, ejecuta primero:
   `ocr-expediente ocr RUTA/archivo.pdf` (también acepta una carpeta).
   Imprime una línea por archivo con las páginas, los caracteres y las páginas con poco texto. Si dice `OMITIDO`, ya estaba procesado: úsalo.
3. Trabaja sobre el `.txt` resultante, que trae marcas `=== Folio N ===`. **No lo leas completo.** Usa:
   - `ocr-expediente buscar archivo.txt "término"` → folio y línea de cada coincidencia.
   - `ocr-expediente folio archivo.txt 12-15` → solo esos folios.
4. Para comparar dos versiones: `ocr-expediente comparar A.txt B.txt` y analiza solo las diferencias; no leas ambos documentos enteros.
5. Solo mira la imagen de una página si figura en "pág. con poco texto" o si el OCR es dudoso, y solo esa página. En el texto marca `[ilegible]` o `[dudoso]`; no adivines letras ni cifras.
6. Antes de citar literalmente un pasaje (nombres, números de expediente, fechas, cifras, artículos), cotéjalo con la imagen de esa página: el OCR se equivoca justo ahí.
7. Si imprime `FALLO`, dilo tal cual al usuario con el motivo; no inventes el contenido del documento.
8. No modifiques ni sobrescribas el PDF original.
<!-- ocr-expediente:fin -->
