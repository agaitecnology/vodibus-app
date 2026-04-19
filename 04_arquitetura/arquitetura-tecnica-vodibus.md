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
