#!/usr/bin/env sh
# Instala la wiki en esta computadora (Mac/Linux) y hace que todas las sesiones de Claude Code la conozcan.
# Uso: sh setup.sh      Requiere git (y GitHub CLI + "gh auth login" para subir cambios).
set -e
REPO=https://github.com/gnomodelmar/verified-llm-wiki.git
DEST="$HOME/verified-llm-wiki"
LINE='@~/verified-llm-wiki/CLAUDE-WIKI.md'

command -v git >/dev/null 2>&1 || { echo "Falta git. Instalalo y volve a correr este script."; exit 1; }

if [ -d "$DEST/.git" ]; then
  git -C "$DEST" pull --ff-only
else
  git clone "$REPO" "$DEST"
  git -C "$DEST" remote add upstream https://github.com/Loren292/verified-llm-wiki.git
fi

mkdir -p "$HOME/.claude"
CLAUDE_MD="$HOME/.claude/CLAUDE.md"
touch "$CLAUDE_MD"
if ! grep -qF "$LINE" "$CLAUDE_MD"; then
  printf '\n\n# Verified LLM Wiki (todas las sesiones)\nTomas mantiene una wiki de metodo que todas las sesiones deben ir mejorando. Reglas:\n%s\n' "$LINE" >> "$CLAUDE_MD"
  echo "Agregado el import en $CLAUDE_MD"
else
  echo "El import ya estaba en $CLAUDE_MD"
fi
echo "Listo. Wiki en $DEST"
