# Instala la wiki en esta computadora (Windows) y hace que todas las sesiones de Claude Code la conozcan.
# Uso: descargar este archivo y correr:  powershell -ExecutionPolicy Bypass -File setup.ps1
# Requiere git. Si falta:  winget install --id Git.Git -e   (y GitHub CLI para subir: winget install --id GitHub.cli -e; luego gh auth login)

$ErrorActionPreference = 'Stop'
$repo  = 'https://github.com/gnomodelmar/verified-llm-wiki.git'
$dest  = Join-Path $HOME 'verified-llm-wiki'
$line  = '@~/verified-llm-wiki/CLAUDE-WIKI.md'

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host 'Falta git. Instalalo con: winget install --id Git.Git -e   y volve a correr este script.'
    exit 1
}

# 1. Clonar o actualizar la copia local
if (Test-Path (Join-Path $dest '.git')) {
    git -C $dest pull --ff-only
} else {
    git clone $repo $dest
    git -C $dest remote add upstream https://github.com/Loren292/verified-llm-wiki.git
}

# 2. Importar las reglas en la configuracion global de Claude Code (sin pisar lo que ya haya)
$claudeDir = Join-Path $HOME '.claude'
$claudeMd  = Join-Path $claudeDir 'CLAUDE.md'
if (-not (Test-Path $claudeDir)) { New-Item -ItemType Directory -Path $claudeDir | Out-Null }
$current = ''
if (Test-Path $claudeMd) { $current = [IO.File]::ReadAllText($claudeMd) }
if ($current -notmatch [regex]::Escape($line)) {
    $block = "`r`n`r`n# Verified LLM Wiki (todas las sesiones)`r`nTomas mantiene una wiki de metodo que todas las sesiones deben ir mejorando. Reglas:`r`n$line`r`n"
    [IO.File]::AppendAllText($claudeMd, $block, (New-Object System.Text.UTF8Encoding($false)))
    Write-Host "Agregado el import en $claudeMd"
} else {
    Write-Host "El import ya estaba en $claudeMd"
}
Write-Host "Listo. Wiki en $dest"
