# Script de Organização VoDiBus!
# Cria estrutura completa de pastas no Drive D:
# Execute no PowerShell: .\criar-estrutura-vodibus.ps1

Write-Host "🚌 Criando estrutura de pastas do VoDiBus no Drive D:..." -ForegroundColor Cyan

# Criar pasta raiz no D:
$raiz = "D:\VoDiBus"

# Verificar se D: existe
if (-not (Test-Path "D:\")) {
    Write-Host "❌ Drive D: não encontrado!" -ForegroundColor Red
    Write-Host "💡 Edite o script e mude D: para C: ou outro drive" -ForegroundColor Yellow
    exit
}

Write-Host "📁 Criando estrutura em: $raiz" -ForegroundColor Green

# Criar todas as pastas
$pastas = @(
    # 1. Planejamento
    "01-Planejamento\Mockups\screenshots",
    "01-Planejamento\Mockups\historico",
    "01-Planejamento\Documentacao",
    "01-Planejamento\Design\Logo",
    "01-Planejamento\Design\Assets\icones",
    "01-Planejamento\Design\Assets\ilustracoes",
    "01-Planejamento\Design\Assets\screenshots",
    "01-Planejamento\Design\Guias",
    "01-Planejamento\Apresentacoes\demo-screenshots",
    
    # 2. Desenvolvimento
    "02-Desenvolvimento\codigo-fonte",
    "02-Desenvolvimento\prototipos\html-prototypes",
    "02-Desenvolvimento\prototipos\figma-exports",
    "02-Desenvolvimento\scripts",
    
    # 3. Testes
    "03-Testes\validacao\fotos",
    "03-Testes\testes-tecnicos\gps-tests",
    "03-Testes\testes-tecnicos\ocr-tests",
    "03-Testes\testes-tecnicos\performance",
    
    # 4. Releases
    "04-Releases\v0.1.0-alpha",
    "04-Releases\v0.2.0-beta",
    "04-Releases\v1.0.0-release",
    
    # 5. Administrativo
    "05-Administrativo\contratos",
    "05-Administrativo\orcamentos",
    "05-Administrativo\reunioes\atas"
)

# Criar cada pasta
foreach ($pasta in $pastas) {
    $caminhoCompleto = Join-Path $raiz $pasta
    New-Item -Path $caminhoCompleto -ItemType Directory -Force | Out-Null
    Write-Host "  ✓ $pasta" -ForegroundColor Gray
}

Write-Host ""
Write-Host "✅ Estrutura criada com sucesso!" -ForegroundColor Green
Write-Host ""
Write-Host "📂 Caminho: $raiz" -ForegroundColor Cyan
Write-Host ""
Write-Host "📋 Pastas principais criadas:" -ForegroundColor Yellow
Write-Host "   📁 01-Planejamento\" -ForegroundColor White
Write-Host "   📁 02-Desenvolvimento\" -ForegroundColor White
Write-Host "   📁 03-Testes\" -ForegroundColor White
Write-Host "   📁 04-Releases\" -ForegroundColor White
Write-Host "   📁 05-Administrativo\" -ForegroundColor White
Write-Host ""
Write-Host "🎯 Próximo passo:" -ForegroundColor Cyan
Write-Host "   1. Copiar mockup para: $raiz\01-Planejamento\Mockups\" -ForegroundColor White
Write-Host "   2. Copiar logo para: $raiz\01-Planejamento\Design\Logo\" -ForegroundColor White
Write-Host "   3. Copiar README.md para: $raiz\" -ForegroundColor White
Write-Host ""
Write-Host "🚀 Abrir pasta agora? (S/N)" -ForegroundColor Yellow
$resposta = Read-Host

if ($resposta -eq "S" -or $resposta -eq "s") {
    explorer $raiz
}
