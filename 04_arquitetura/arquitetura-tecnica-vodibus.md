\# Arquitetura Técnica — VoDiBus!



\*\*Projeto:\*\* VoDiBus!

\*\*Versão:\*\* 0.1.0

\*\*Data:\*\* 2026-04-19

\*\*Responsável:\*\* Agaitecnology



\---



\## 1. Visão Geral



Aplicativo mobile de navegação urbana por ônibus, voltado para

usuários que se beneficiam de interfaces digitais simplificadas.

Desenvolvido em Flutter para Android (target principal) e Web.



\---



\## 2. Stack Tecnológica



| Camada | Tecnologia |

|---|---|

| Framework | Flutter 3.41.6 (stable) |

| Linguagem | Dart 3.11.3 |

| Plataforma alvo | Android, Web |

| IDE | VS Code |

| Versionamento | Git + GitHub (org: Agaitecnology) |

| SDK Android | 36.1.0 |



\---



\## 3. Estrutura de Pastas

vodibus\_app/

├── lib/

│   ├── main.dart              # Entrada do app e navegação principal

│   ├── theme/

│   │   └── app\_colors.dart    # Paleta de cores oficial

│   └── screens/

│       ├── splash\_screen.dart

│       ├── home\_screen.dart

│       ├── resultados\_screen.dart

│       ├── detalhe\_screen.dart

│       └── favoritos\_screen.dart

├── test/

│   └── widget\_test.dart

└── pubspec.yaml



\---



\## 4. Paleta de Cores Oficial



| Nome | Hex | Uso |

|---|---|---|

| Azul Escuro | #1E3A5F | Estrutura, AppBar, badges |

| Amarelo | #FFC107 | Destaque — "Di" no logo |

| Azul Médio | #007AFF | Ação — botões, ícones |

| Verde-Azulado | #E8F5F0 | Fundo splash |

| Verde | #34C759 | Confirmações, horários |

| Branco | #FFFFFF | Cards, fundos |

| Cinza Fundo | #F5F5F5 | Background telas |

| Cinza Texto | #666666 | Textos secundários |



\---



\## 5. Telas Implementadas



| Tela | Arquivo | Status |

|---|---|---|

| Splash | splash\_screen.dart | ✅ |

| Home | home\_screen.dart | ✅ |

| Resultados | resultados\_screen.dart | ✅ |

| Detalhe da linha | detalhe\_screen.dart | ✅ |

| Favoritos | favoritos\_screen.dart | ✅ |

| Viagem (contador) | trip\_screen.dart | 🔜 |

| Navegação a pé | walking\_screen.dart | 🔜 |



\---



\## 6. Navegação



\- \*\*MainScreen\*\* gerencia a barra inferior (Buscar / Favoritos)

\- \*\*SplashScreen\*\* redireciona para MainScreen após 3 segundos

\- Navegação entre telas via `Navigator.push` / `Navigator.pushReplacement`



\---



\## 7. Decisões Técnicas



\- \*\*Sem gerenciador de estado externo\*\* na v0.1 — setState suficiente

\- \*\*Dados mockados\*\* em todas as telas — integração com API real prevista

\- \*\*AppColors centralizado\*\* — qualquer mudança de paleta afeta um único arquivo

\- \*\*Material 3\*\* habilitado com seedColor oficial



\---



\## 8. Próximos Passos



\- \[ ] Tela de viagem com contador de paradas

\- \[ ] Tela de navegação a pé

\- \[ ] Integração GPS real

\- \[ ] Integração com API de linhas de ônibus

\- \[ ] Acessibilidade — TTS (Text to Speech)

\- \[ ] Input por voz (Speech to Text)

\- \[ ] OCR para leitura de endereços



\---



\## 9. Requisitos Futuros — Identificados em Desenvolvimento



\### 9.1 Gestão de Intercorrências no Trânsito



Situações que afetam a contagem de paradas e roteirização:



\- Desvios por acidentes

\- Obras e reparos em vias públicas

\- Bloqueios temporários

\- Alterações de itinerário pelo operador



\*\*Impacto no app:\*\*

\- Contador de paradas precisa ser dinâmico, não fixo

\- Sistema deve receber alertas em tempo real

\- Usuário deve ser notificado de mudanças na rota

\- Previsão de chegada deve ser recalculada



\*\*Solução prevista:\*\*

\- Integração com API de trânsito em tempo real

\- Notificações push para alterações de rota

\- Sincronização com dados das operadoras de ônibus



> 📌 Registrado em: 19/04/2026

> Origem: observação durante desenvolvimento da TripScreen


---

## 10. Build e Distribuição

### APK Release
**Comando:** `flutter build apk --release`
**Localização:** `build\app\outputs\apk\release\app-release.apk`
**Versão atual:** 0.4.0
**Data:** 19/04/2026

### Observações
- Antes do build rodar `flutter clean`
- Verificar processos dart.exe no Gerenciador de Tarefas
- APK pode ser instalado via WhatsApp ou cabo USB
- Play Protect exibirá aviso — clicar "Instalar mesmo assim"

---

## 11. Requisitos Funcionais — Roteirização Completa

### 11.1 Fluxo esperado pelo usuário

1. Usuário informa destino (digitando, voz ou OCR)
2. App identifica localização atual via GPS
3. App calcula **ponto de ônibus mais próximo** do usuário
4. App sugere **linha mais adequada** para o destino
5. App exibe **rota a pé** até o ponto de embarque
6. App informa **horário previsto** de chegada do ônibus
7. App calcula **tempo estimado** entre "estou aqui" e embarque
8. Durante a viagem — contador de paradas em tempo real

### 11.2 Dados necessários para implementação

| Dado | Fonte | Status |
|---|---|---|
| Localização do usuário | GPS real | ✅ implementado |
| Pontos de parada | GTFS stops.txt | 🔜 expandir |
| Linhas e itinerários | GTFS routes.txt | ✅ parcial |
| Horários das linhas | GTFS stop_times.txt | 🔜 expandir |
| Rota a pé até o ponto | Google Maps / OSM | 🔜 integrar |
| Tempo estimado a pé | Cálculo por distância | 🔜 implementar |
| Previsão chegada ônibus | API RioPretrans | 🔜 aguarda API |

### 11.3 Algoritmo de sugestão de linha

1. Obter coordenadas do usuário
2. Calcular distância para todos os pontos de parada
3. Filtrar pontos das linhas que atendem o destino
4. Ordenar por: menor distância a pé + menor tempo de espera
5. Retornar top 3 opções ao usuário

> 📌 Registrado em: 19/04/2026
> Origem: definição de produto durante desenvolvimento


---

## 12. Fluxo Completo de Navegação — VoDiBus!

### 12.1 Sequência de Orientação ao Usuário

**PASSO 1 — ORIGEM**
- 📍 Você está aqui — [endereço GPS completo]
- Referência visual do local atual

**PASSO 2 — A PÉ ATÉ O PONTO**
- 🚶 Saia pela [direita/esquerda]
- Referências visuais — "após a padaria", "em frente ao banco"
- Indicação de travessia de rua
- Semáforos no caminho
- 🚶 Caminhe [X metros] até o ponto [Y]
- ⏱ [N minutos a pé]

**PASSO 3 — EMBARQUE**
- 🚌 Aguarde o ônibus [Linha Z]
- Sentido da linha — "em direção ao Terminal Norte"
- Número e letreiro visual do ônibus
- Plataforma específica no terminal
- ⏰ Próximo horário: [HH:MM]
- ⏱ Tempo de espera: [N min]

**PASSO 4 — DURANTE A VIAGEM**
- ✅ Confirmação de embarque no ônibus correto
- 🔢 Siga por [N paradas]
- Nome das paradas intermediárias relevantes
- ⚠️ Alerta antecipado — "prepare-se, faltam 2 paradas"
- ⚠️ DESEMBARQUE em [Terminal/Parada X]

**PASSO 5 — BALDEAÇÃO (se necessário)**
- 🔄 No Terminal Central:
- Tempo disponível para a baldeação
- Localização da plataforma dentro do terminal
- 📍 Vá até a plataforma [X]
- 🚌 Pegue a linha [000] — horário [HH:MM]
- O que fazer se perder o horário
- 🔢 Siga por [N paradas]

**PASSO 6 — DESTINO FINAL**
- 🚶 Desembarque em [Parada X]
- Referência visual do ponto de desembarque
- 🚶 Siga pela [direita/esquerda]
- 📍 Caminhe [N metros]
- ✅ Você chegou ao seu destino!

---

### 12.2 Requisitos Técnicos por Passo

| Passo | Dados necessários | Fonte |
|---|---|---|
| Origem | GPS + geocoding | Geolocator + Geocoding |
| A pé até ponto | Rota pedestre + POIs | OpenStreetMap / Google Maps |
| Embarque | Horários + plataforma | API RioPretrans / GTFS |
| Durante viagem | GPS em tempo real + paradas | GPS + GTFS |
| Baldeação | Mapa do terminal + horários | Dados RioPretrans |
| Destino final | Rota pedestre + POIs | OpenStreetMap / Google Maps |

---

### 12.3 Funcionalidades de Acessibilidade por Passo

| Passo | Recurso |
|---|---|
| Todos | TTS — leitura em voz alta |
| A pé | Vibração a cada curva |
| Embarque | Alerta sonoro ao chegar o ônibus |
| Viagem | Vibração + som ao aproximar da parada |
| Destino | Vibração + voz "Você chegou!" |

---

---

## 12. Fluxo Completo de Navegação — VoDiBus!

### 12.1 Sequência de Orientação ao Usuário

**PASSO 1 — ORIGEM**
- 📍 Você está aqui — [endereço GPS completo]
- Referência visual do local atual

**PASSO 2 — A PÉ ATÉ O PONTO**
- 🚶 Saia pela [direita/esquerda]
- Referências visuais — "após a padaria", "em frente ao banco"
- Indicação de travessia de rua
- Semáforos no caminho
- 🚶 Caminhe [X metros] até o ponto [Y]
- ⏱ [N minutos a pé]

**PASSO 3 — EMBARQUE**
- 🚌 Aguarde o ônibus [Linha Z]
- Sentido da linha — "em direção ao Terminal Norte"
- Número e letreiro visual do ônibus
- Plataforma específica no terminal
- ⏰ Próximo horário: [HH:MM]
- ⏱ Tempo de espera: [N min]

**PASSO 4 — DURANTE A VIAGEM**
- ✅ Confirmação de embarque no ônibus correto
- 🔢 Siga por [N paradas]
- Nome das paradas intermediárias relevantes
- ⚠️ Alerta antecipado — "prepare-se, faltam 2 paradas"
- ⚠️ DESEMBARQUE em [Terminal/Parada X]

**PASSO 5 — BALDEAÇÃO (se necessário)**
- 🔄 No Terminal Central:
- Tempo disponível para a baldeação
- Localização da plataforma dentro do terminal
- 📍 Vá até a plataforma [X]
- 🚌 Pegue a linha [000] — horário [HH:MM]
- O que fazer se perder o horário
- 🔢 Siga por [N paradas]

**PASSO 6 — DESTINO FINAL**
- 🚶 Desembarque em [Parada X]
- Referência visual do ponto de desembarque
- 🚶 Siga pela [direita/esquerda]
- 📍 Caminhe [N metros]
- ✅ Você chegou ao seu destino!

---

### 12.2 Requisitos Técnicos por Passo

| Passo | Dados necessários | Fonte |
|---|---|---|
| Origem | GPS + geocoding | Geolocator + Geocoding |
| A pé até ponto | Rota pedestre + POIs | OpenStreetMap / Google Maps |
| Embarque | Horários + plataforma | API RioPretrans / GTFS |
| Durante viagem | GPS em tempo real + paradas | GPS + GTFS |
| Baldeação | Mapa do terminal + horários | Dados RioPretrans |
| Destino final | Rota pedestre + POIs | OpenStreetMap / Google Maps |

---

### 12.3 Funcionalidades de Acessibilidade por Passo

| Passo | Recurso |
|---|---|
| Todos | TTS — leitura em voz alta |
| A pé | Vibração a cada curva |
| Embarque | Alerta sonoro ao chegar o ônibus |
| Viagem | Vibração + som ao aproximar da parada |
| Destino | Vibração + voz "Você chegou!" |

---

### 12.4 Tratamento de Intercorrências

- Ônibus atrasado → recalcular tempo de espera
- Desvio de rota → notificar e recalcular
- Perda de baldeação → sugerir próxima alternativa
- GPS perdido → usar última posição conhecida
- Sem internet → modo offline com dados em cache

> 📌 Registrado em: 21/04/2026
> Origem: definição de produto — fluxo completo de navegação