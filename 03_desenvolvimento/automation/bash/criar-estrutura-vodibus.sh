#!/bin/bash

# Script de Organização VoDiBus!
# Cria estrutura completa de pastas no Drive D:

echo "🚌 Criando estrutura de pastas do VoDiBus no Drive D:..."

# Navegar para D: (Windows)
# Se estiver no Git Bash: cd /d
# Se estiver no PowerShell ou CMD: D: && cd \

# Criar pasta raiz no D:
mkdir -p /d/VoDiBus

cd /d/VoDiBus

# 1. Planejamento
mkdir -p 01-Planejamento/Mockups/screenshots
mkdir -p 01-Planejamento/Mockups/historico
mkdir -p 01-Planejamento/Documentacao
mkdir -p 01-Planejamento/Design/Logo
mkdir -p 01-Planejamento/Design/Assets/icones
mkdir -p 01-Planejamento/Design/Assets/ilustracoes
mkdir -p 01-Planejamento/Design/Assets/screenshots
mkdir -p 01-Planejamento/Design/Guias
mkdir -p 01-Planejamento/Apresentacoes/demo-screenshots

# 2. Desenvolvimento
mkdir -p 02-Desenvolvimento/codigo-fonte
mkdir -p 02-Desenvolvimento/prototipos/html-prototypes
mkdir -p 02-Desenvolvimento/prototipos/figma-exports
mkdir -p 02-Desenvolvimento/scripts

# 3. Testes
mkdir -p 03-Testes/validacao/fotos
mkdir -p 03-Testes/testes-tecnicos/gps-tests
mkdir -p 03-Testes/testes-tecnicos/ocr-tests
mkdir -p 03-Testes/testes-tecnicos/performance

# 4. Releases
mkdir -p 04-Releases/v0.1.0-alpha
mkdir -p 04-Releases/v0.2.0-beta
mkdir -p 04-Releases/v1.0.0-release

# 5. Administrativo
mkdir -p 05-Administrativo/contratos
mkdir -p 05-Administrativo/orcamentos
mkdir -p 05-Administrativo/reunioes/atas

echo ""
echo "✅ Estrutura criada com sucesso em D:\VoDiBus!"
echo ""
echo "📁 Caminho completo: D:\VoDiBus\"
echo ""
echo "📂 Pastas principais criadas:"
echo "   01-Planejamento/"
echo "   02-Desenvolvimento/"
echo "   03-Testes/"
echo "   04-Releases/"
echo "   05-Administrativo/"
echo ""
echo "🎯 Próximo passo: Copiar arquivos para as pastas corretas!"

