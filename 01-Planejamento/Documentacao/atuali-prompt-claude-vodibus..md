# 📌 Atualização de Estrutura do Projeto VoDiBus (Revisado)

## 🧠 Contexto

Projeto VoDiBus estruturado com foco profissional, separando claramente planejamento, produto, desenvolvimento e operação. Estrutura local organizada e sincronizada com GitHub.

Este documento foi **revisado e consolidado** para evitar inconsistências e servir como base única para definição de arquitetura.

\---

# 💻 Estrutura Local (PC)

Caminho raiz:

```
D:\\AgAi-Tec\\projetos\\VoDiBus
```

Estrutura atual (padronizada):

```
VoDiBus
│   .gitignore
│   README.md
│
├── 01-planejamento
│   ├── documentacao
│   │       design-system.md
│   │
│   ├── estrategia
│   │       definicao-estrategica.md
│   │
│   └── produto-visao
│           ideia-vodibus.md
│           visao-geral.md
│
├── 02-produto
│   ├── design
│   │   ├── assets
│   │   ├── logo
│   │   │   ├── estudos
│   │   │   ├── final
│   │   │   └── versoes
│   │   └── referencias
│   │
│   └── mockups
│       ├── versao-atual
│       └── versoes-antigas
│
├── 03-desenvolvimento
│   ├── automation
│   │   ├── bash
│   │   └── powershell
│   │
│   └── vodibus\_app   ← (ponto de início do app)
│
├── 04-testes
├── 05-deploy
└── 06-administrativo
```

\---

# 🌐 Estrutura no GitHub

* Repositório: conectado e funcional
* Branch principal: `main`
* Estrutura sincronizada com repositório remoto
* Commit inicial realizado com organização completa

\---

# ✅ Decisões Consolidadas

## 📂 Organização por fases

* Planejamento → estratégia e visão
* Produto → design e protótipos
* Desenvolvimento → código e automação
* Testes → validação
* Deploy → entrega
* Administrativo → gestão

\---

## 🧱 Padrão de nomenclatura

* kebab-case obrigatório
* sem espaços
* sem acentos
* sem caracteres especiais

Exemplo:

```
produto-visao
versao-atual
design-system.md
```

\---

## ⚙️ Automação

Scripts separados por ambiente:

* bash
* powershell

Objetivo:

* padronização
* repetibilidade
* setup rápido

\---

# 🚀 Status Atual

✅ Estrutura validada e consistente  
✅ GitHub integrado e funcionando  
✅ Documentação base criada  
⚠️ Desenvolvimento ainda não iniciado

\---

# 🎯 Próximo Passo (Crítico)

Iniciar o app em:

```
03-desenvolvimento/vodibus\_app
```

\---

# 🧠 Prompt Revisado para Arquitetura (Claude)

Copie e utilize:

```
Você é um arquiteto de software sênior.

Contexto:
Estou iniciando o desenvolvimento do app VoDiBus.

O objetivo do app é ajudar usuários de transporte público a:
- identificar sua localização
- entender onde estão
- escolher a melhor rota
- identificar o melhor ônibus até o destino

O projeto já está estruturado profissionalmente.

Estrutura principal:
- 01-planejamento → estratégia e visão
- 02-produto → design e mockups
- 03-desenvolvimento → onde o app será criado
- Pasta do app: 03-desenvolvimento/vodibus\_app

Documentos disponíveis:
- design-system.md
- ideia-vodibus.md
- visao-geral.md

Objetivo:
Quero iniciar com uma arquitetura limpa, escalável e profissional, evitando retrabalho.

Tarefas:

1. Definir a melhor stack inicial
   (Flutter, Web, ou outra)
   considerando:
   - rapidez
   - escalabilidade
   - simplicidade inicial

2. Definir arquitetura do projeto
   incluindo:
   - estrutura de pastas
   - separação por camadas
     (presentation, domain, data)
   - organização por features

3. Definir padrões iniciais
   - gerenciamento de estado
   - navegação
   - integração com APIs
   - uso de GPS/localização

4. Definir boas práticas
   - versionamento
   - organização de código
   - padrões de naming

5. Gerar estrutura inicial de diretórios
   dentro de:
   vodibus\_app

6. Sugerir comandos iniciais
   para criar o projeto via CLI

Regras:
- evitar complexidade desnecessária
- priorizar clareza
- preparar para crescimento

Saída esperada:
- explicação clara
- estrutura de pastas pronta
- justificativas técnicas
```

\---

# 🧭 Diretriz de Gestor

A partir deste ponto:

❌ Não voltar para reorganização estrutural  
✅ Foco total em iniciar o produto

Este documento representa o fechamento da fase de organização e o início da execução.

\---

