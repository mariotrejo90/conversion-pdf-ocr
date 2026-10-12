# Prompts para que cada IA use el flujo `ocr-expediente`

Cada IA que **no** pueda ejecutar comandos en su Mac trabaja en "modo relevo": usted corre `ocr-expediente` y le entrega el `.txt` o los folios. Ojo: el texto que le entregue llega a ese proveedor; no lo haga con datos de expedientes o clientes si el modelo es externo.

---

## 1. Claude normal (app de escritorio): mejorar el skill `ocrmypdf-expedientes`

```
Usa el skill skill-creator para mejorar mi skill "ocrmypdf-expedientes". No lo reescribas entero: muéstrame primero los cambios propuestos (antes y después) y espera mi aprobación antes de guardar.

Contexto: instalé en mi Mac el comando `ocr-expediente` (en ~/.local/bin; repositorio github.com/mariotrejo90/conversion-pdf-ocr). Subcomandos:
- `ocr-expediente ocr ARCHIVO.pdf|CARPETA`: OCR local en español; deja NOMBRE_ocr.pdf y NOMBRE.txt con marcas "=== Folio N ===". Imprime una línea por archivo (OK / OMITIDO / FALLO) con páginas, caracteres y "pág. con poco texto".
- `ocr-expediente buscar NOMBRE.txt "texto"`: folio y línea de cada coincidencia.
- `ocr-expediente folio NOMBRE.txt 12-15`: solo esos folios.
- `ocr-expediente comparar A.txt B.txt`: solo las diferencias entre dos textos.

Cambios que quiero:
1. En la comprobación del entorno: primero `command -v ocr-expediente`. Si existe, es la vía principal; el script actual del skill queda como respaldo. Si no hay shell en mi Mac, dilo y dame el comando para que lo ejecute yo.
2. Prohibido leer un PDF escaneado como imágenes página por página y prohibidas las capturas de pantalla para leerlo. Siempre OCR primero.
3. No leer el .txt completo salvo que yo lo pida: usar `buscar` y `folio`. Para comparar versiones, usar `comparar` y analizar solo las diferencias.
4. Solo ver como imagen las páginas listadas en "pág. con poco texto" o las dudosas, y solo esas.
5. Si imprime FALLO, decírmelo con el motivo; nunca inventar el contenido.
6. Conservar todo lo que el skill ya dice: originales intactos, PDF firmados o cifrados sin forzar, cotejo contra la imagen antes de citar literalmente nombres, números de expediente, fechas, cifras y artículos, marcar [ilegible] o [dudoso], y privacidad (nada a servicios en línea).
7. Para el Contexto.MD, agrega como OPCIÓN una variante compacta: índice por documento, hechos clave, fechas y el folio de donde sale cada dato, con el texto completo dejado en el .txt. No reemplaces la variante actual; pregúntame cuál usar en cada caso.

Cuando yo apruebe, guarda el skill y pruébalo con un PDF mío que no sea de un cliente.
```

---

## 2. Hermes

```
Guarda como regla permanente (en tu memoria persistente o archivo de instrucciones, el que uses para eso) lo siguiente, y confírmame dónde la guardaste:

REGLA: OCR de PDF escaneados. En esta máquina existe el comando local `ocr-expediente` (Tesseract; nada sale a internet). Antes de leer cualquier PDF ejecuta en la terminal `ocr-expediente ocr RUTA/archivo.pdf` (acepta carpetas). Nunca leas un escaneo como imagen ni con capturas de pantalla. Trabaja sobre el .txt resultante, que tiene marcas "=== Folio N ===", sin leerlo completo: usa `ocr-expediente buscar archivo.txt "término"` y `ocr-expediente folio archivo.txt 12-15`. Para comparar dos versiones usa `ocr-expediente comparar A.txt B.txt` y analiza solo las diferencias. Solo mira la imagen de las páginas que figuren en "pág. con poco texto". Si imprime FALLO, dímelo con el motivo y no inventes el contenido. Antes de citar literalmente nombres, números de expediente, fechas, cifras o artículos, cotéjalos con la imagen de esa página. Nunca modifiques ni sobrescribas el PDF original.

Ahora verifica que funciona: ejecuta `ocr-expediente --help` y dime qué muestra.
```

---

## 3. Gemini

**3a. Gemini CLI** (puede ejecutar comandos en el Mac):

```
Guarda como instrucción permanente en ~/.gemini/GEMINI.md (créalo si no existe, sin borrar lo que ya tenga) la siguiente regla:

OCR de PDF escaneados: existe el comando local `ocr-expediente` (Tesseract; nada sale a internet). Antes de leer cualquier PDF ejecuta `ocr-expediente ocr RUTA/archivo.pdf` (acepta carpetas). Nunca leas un escaneo como imagen ni con capturas. Trabaja sobre el .txt (marcas "=== Folio N ===") sin leerlo completo: `ocr-expediente buscar archivo.txt "término"` y `ocr-expediente folio archivo.txt 12-15`. Para comparar usa `ocr-expediente comparar A.txt B.txt` y analiza solo las diferencias. Mira la imagen solo de las páginas en "pág. con poco texto". Si imprime FALLO, dímelo con el motivo y no inventes el contenido. Cotejo con la imagen antes de citar literalmente nombres, números, fechas, cifras o artículos. Nunca modifiques el PDF original.

Luego ejecuta `ocr-expediente --help` para comprobarlo.
```

**3b. Gemini en la web o la app** (no puede ejecutar nada en el Mac; modo relevo):

```
Trabajaremos en "modo relevo". Tú no puedes ejecutar comandos en mi computadora, así que yo corro una herramienta local de OCR y te paso el resultado.

Reglas:
- No me pidas el PDF escaneado ni capturas de cada página. Te daré el texto ya extraído (.txt), que trae marcas "=== Folio N ===" por página.
- No me pidas el documento completo. Dime qué folios necesitas (por ejemplo "folios 12 a 15") o qué término debo buscar, y te lo paso. Yo uso: `ocr-expediente folio archivo.txt 12-15` y `ocr-expediente buscar archivo.txt "término"`.
- Para comparar dos versiones te paso solo la salida de `ocr-expediente comparar A.txt B.txt`.
- Si hay una página con poco texto o dudosa, te la señalo y la revisamos solo esa.
- El texto puede tener errores de OCR. Antes de citar literalmente nombres, números de expediente, fechas, cifras o artículos, avísame para cotejarlos contra la imagen.
- Si no tienes un dato, dilo; no lo inventes.

Confirma que entendiste y dime qué necesitas primero.
```

---

## 4. ChatGPT

**4a. ChatGPT en la web o la app** (modo relevo):

```
Trabajaremos en "modo relevo". Tú no ejecutas comandos en mi computadora: yo corro una herramienta local de OCR (Tesseract) y te paso el resultado.

Reglas:
- No me pidas el PDF escaneado completo ni capturas de cada página. Te daré el texto ya extraído (.txt), con marcas "=== Folio N ===" por página.
- No me pidas todo el texto. Dime qué folios necesitas ("folios 12 a 15") o qué término buscar. Yo uso `ocr-expediente folio archivo.txt 12-15` y `ocr-expediente buscar archivo.txt "término"`.
- Para comparar dos versiones te paso solo la salida de `ocr-expediente comparar A.txt B.txt`.
- Las páginas con poco texto o dudosas las revisamos una por una.
- El OCR puede equivocarse en nombres propios, números de expediente, fechas, cifras y artículos: antes de citarlos literalmente, avísame para cotejarlos con la imagen.
- Si no tienes un dato, dilo; no lo inventes.

Confirma que entendiste y dime qué necesitas primero.
```

**4b. Codex CLI** (si lo usa en la Terminal, puede ejecutar comandos):

```
Agrega al archivo AGENTS.md (en mi carpeta de trabajo o en ~/.codex/AGENTS.md; sin borrar lo existente) este bloque:

OCR de PDF escaneados: existe el comando local `ocr-expediente` (Tesseract; nada sale a internet). Antes de leer un PDF ejecuta `ocr-expediente ocr RUTA/archivo.pdf`. Nunca leas escaneos como imagen. Trabaja sobre el .txt (marcas "=== Folio N ===") sin leerlo completo: `ocr-expediente buscar archivo.txt "término"` y `ocr-expediente folio archivo.txt 12-15`. Para comparar usa `ocr-expediente comparar A.txt B.txt`. Si imprime FALLO, dilo y no inventes. Cotejo con la imagen antes de citar literalmente. No modifiques el PDF original.

Luego ejecuta `ocr-expediente --help` para comprobarlo.
```
