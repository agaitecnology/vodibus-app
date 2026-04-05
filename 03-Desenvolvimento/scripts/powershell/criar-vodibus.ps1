$raiz = "D:\VoDiBus"

$pastas = @(
    "01-Planejamento",
    "02-Desenvolvimento",
    "03-Testes",
    "04-Releases",
    "05-Administrativo"
)

# Criar pasta raiz
if (!(Test-Path $raiz)) {
    New-Item -ItemType Directory -Path $raiz
}

# Criar subpastas
foreach ($pasta in $pastas) {
    $caminho = Join-Path $raiz $pasta
    if (!(Test-Path $caminho)) {
        New-Item -ItemType Directory -Path $caminho
    }
}

Write-Host "Estrutura criada com sucesso!" -ForegroundColor Green
Write-Host "Caminho: $raiz"