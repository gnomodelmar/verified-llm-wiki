# Verified LLM Wiki: reglas para todas las sesiones de Claude de Tomás

Este archivo lo importa `~/.claude/CLAUDE.md` en cada computadora de Tomás (lo instala `setup.ps1` o `setup.sh`). Por eso lo leen **todas** sus sesiones de Claude Code, en cualquier proyecto.

- **Repo:** https://github.com/gnomodelmar/verified-llm-wiki (público, mantenido por Tomás).
- **Copia local:** `~/verified-llm-wiki` (en Windows, `C:\Users\<usuario>\verified-llm-wiki`).
- **Origen:** está basada en https://github.com/Loren292/verified-llm-wiki (remoto `upstream`, licencia MIT). Ahí está el método completo: `README.es.md` y `template/CLAUDE.md`.

## 1. Qué es y para qué se usa

La wiki es un **método**, no los datos de un proyecto. Es el patrón LLM Wiki de Karpathy con una capa de verificación: `tools/wikicheck.py`, registro de decisiones D/H/T/P, citas verificables, revisión en frío y log de firmas.

Tomás la usa en varios proyectos y la va mejorando con lo que aparece trabajando con Claude. Todas las sesiones deben aportar a esa mejora.

## 2. Cuándo proponer una mejora

Proponé una mejora cuando, trabajando con Tomás en **cualquier** proyecto, pase alguna de estas cosas:

- Una regla del método falló, resultó ambigua o no se cumplió, y eso causó un error.
- Un error se repitió (es la "pregunta de repetición" del ciclo, sección 8 del README).
- Una tarea mecánica se hizo a mano dos veces y podría ir a `wikicheck.py` o a un script.
- Hace falta un rol, un workflow o un chequeo que no existe.
- Tomás corrige cómo debe trabajar un agente, y esa corrección sirve para cualquier proyecto, no solo para el actual.

**No va a la wiki:**

- Datos, cifras, nombres o decisiones de un proyecto puntual. Eso queda en ese proyecto.
- Información personal, credenciales o rutas privadas.

Hay que generalizar la lección, como hace el README: "una vez pasó X", sin detalles del caso.

## 3. Cómo se aporta (en orden)

1. **Proponer primero.** Contale a Tomás en una o dos líneas qué cambiarías, en qué archivo y qué error lo motivó. **Esperá su OK.** Es la regla del propio método: nada se construye sin aprobación.
2. **Traer lo último.** Corré `git -C ~/verified-llm-wiki pull --ff-only`, porque otra computadora pudo haber subido cambios.
3. **Cambio chico y en su lugar.**
   - Cada regla nueva lleva su `Origin: …`. Si no, el chequeo L7 la marca.
   - Si tocás `README.md`, actualizá también `README.es.md`, y al revés. Lo mismo vale para `template/CLAUDE.md`.
   - Si tocás `tools/wikicheck.py`, agregá en `tests/` un test con un error plantado.
4. **Registrar** el cambio en `MEJORAS.md`: una fila con fecha, proyecto de origen, archivos tocados y motivo.
5. **Subir.**
   - Commit con un mensaje claro que diga el proyecto de origen.
   - `git push`.
   - Si el push falla por cambios remotos: `git pull --rebase` y de nuevo `git push`.
   - **Nunca** uses `--force`.
6. **Verificar.** GitHub Actions corre los tests en cada push. Revisalo con `gh run list -R gnomodelmar/verified-llm-wiki -L 1` y avisale a Tomás si falló.

Origin: pedido de Tomás del 05/11/2026, que quiere que todas sus sesiones, en todas sus computadoras, mejoren la wiki con lo que van viendo.

## 4. Límites

- **Nunca hagas push a `upstream`** (el repo del amigo de Tomás). Si una mejora le sirve, sugerile a Tomás abrir un pull request allá. Lo decide él.
- Si `upstream` tiene novedades (`git fetch upstream`, `git log main..upstream/main`), avisale a Tomás y preguntá si las incorpora.
- Si Tomás tiene cambios sin commitear en la copia local, no los pises. Preguntá primero.
- Si la copia local no existe en esta computadora, decile a Tomás que corra `setup.ps1` (Windows) o `setup.sh` (Mac/Linux) del repo.

## 5. Candidatos (vistos en un solo proyecto)

Lecciones que todavía no son regla: pasaron en un proyecto y esperan a repetirse en otro. Si en tu sesión pasa lo mismo, avisale a Tomás y proponé convertirla en regla (sección 3), citando los dos casos. Si se vuelve regla, se borra de acá.

- **Código con barras invertidas: editarlo con la herramienta de edición, no desde la consola.** En Windows con Git Bash, un heredoc o un `python -c` que escribe código perdió las barras (`\d`, `\n`, `\.`) y dejó regex y textos rotos; lo atraparon las pruebas después. En la misma sesión, escribir con Python en modo texto pasó archivos de LF a CRLF y rompió una prueba que comparaba saltos de línea. Visto 3 veces en NexoLM el 11/11/2026.
