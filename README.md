# 🚌 VoDiBus! 

> *Ônibus na palma da mão — simples assim!*

App de mobilidade urbana focado em acessibilidade para todas as idades.

---

## 📱 Sobre o Projeto

**VoDiBus!** é um aplicativo mobile que simplifica o uso do transporte público, 
especialmente para pessoas com dificuldade em usar apps complexos.

### ✨ Principais Features

- 🎤 **Interface por voz** - Fale onde quer ir
- 📷 **OCR integrado** - Leia endereços em papel
- 🗺️ **Navegação guiada** - Passo a passo com referências visuais
- 🔢 **Contador visual** - Saiba quando descer
- 📍 **GPS automático** - Sem digitação
- 🔊 **Alertas sonoros** - Vibração quando chegar

---

## 🎯 Público-Alvo

### Personas Principais:
1. **Idosos** (60+) - Baixa familiaridade digital
2. **Pessoas com deficiência visual parcial**
3. **Usuários que valorizam simplicidade**

### Diferencial:
- ✅ Botões grandes (90px+)
- ✅ Texto grande (36px+)
- ✅ Poucas opções por tela
- ✅ Linguagem humanizada
- ✅ Feedback constante

---

## 🚀 Status do Projeto

```
✅ Fase 1: Ideação e Planejamento (Concluída)
✅ Fase 2: Mockups Interativos (Concluída)
⏳ Fase 3: Validação com Usuários Reais (03/04/2026)
🔜 Fase 4: Desenvolvimento MVP (Semanas 1-8)
🔜 Fase 5: Testes Beta
🔜 Fase 6: Lançamento v1.0
```

---

## 🛠️ Stack Tecnológica

### Mobile App
- **Framework**: Flutter 3.x
- **Linguagem**: Dart
- **IDE**: VS Code / Android Studio

### Principais Packages
- `geolocator` - GPS e localização
- `google_ml_kit` - OCR (leitura de texto)
- `speech_to_text` - Comando por voz
- `flutter_tts` - Texto para fala
- `vibration` - Alertas táteis

### Backend (Planejado)
- Firebase Authentication
- Cloud Firestore
- Cloud Functions

---

## 📥 Instalação e Uso

### Pré-requisitos
```bash
- Flutter SDK 3.x ou superior
- Android Studio / Xcode
- Git
```

### Clone e Execute
```bash
# Clone o repositório
git clone https://github.com/agaitecnology/vodibus-app.git

# Entre na pasta
cd vodibus-app

# Instale dependências
flutter pub get

# Execute em modo debug
flutter run

# Build para produção
flutter build apk --release
```

---

## 📁 Estrutura do Projeto

```
vodibus-app/
├── lib/
│   ├── main.dart              # Entry point
│   ├── screens/               # Telas do app
│   │   ├── splash_screen.dart
│   │   ├── home_screen.dart
│   │   ├── ocr_screen.dart
│   │   └── ...
│   ├── widgets/               # Componentes reutilizáveis
│   ├── services/              # GPS, OCR, TTS, etc
│   ├── models/                # Modelos de dados
│   └── utils/                 # Utilitários
├── assets/
│   ├── images/
│   ├── icons/
│   └── fonts/
├── test/                      # Testes automatizados
└── docs/                      # Documentação
```

---

## 🎨 Design System

### Cores Oficiais
```dart
// Paleta VoDiBus!
const Color azulEscuro = Color(0xFF1E3A5F);  // Estrutura
const Color amarelo = Color(0xFFFFC107);      // Destaque
const Color azulMedio = Color(0xFF007AFF);    // Ação
const Color verdeAzulado = Color(0xFFE8F5F0); // Calma
const Color verde = Color(0xFF34C759);        // Sucesso
```

### Tipografia
- **Fonte Principal**: Inter Bold (700)
- **Nome VoDiBus!**: Sempre em itálico
- **Tamanhos**: 36px+ para textos principais

---

## 📊 Métricas de Sucesso

### KPIs Principais
- ✅ Taxa de conclusão de viagem > 90%
- ✅ Tempo médio para aprender < 5 minutos
- ✅ NPS (Net Promoter Score) > 70
- ✅ Taxa de erro < 5%

---

## 🧪 Validação e Testes

### Testes Realizados
- [x] Mockup interativo HTML
- [ ] Validação UBS São José do Rio Preto (03/04/2026)
- [ ] Testes de usabilidade com 10+ idosos
- [ ] Testes de performance
- [ ] Testes de acessibilidade

### Feedback Coletado
[Será atualizado após validação UBS]

---

## 🗓️ Roadmap

### v0.1.0 (Alpha) - Semana 1-2
- [ ] Splash screen funcional
- [ ] Navegação entre telas
- [ ] Layout responsivo

### v0.2.0 (Beta) - Semana 3-4
- [ ] Integração GPS
- [ ] Campo de destino funcional
- [ ] OCR básico

### v0.5.0 (MVP) - Semana 5-6
- [ ] Cálculo de rotas
- [ ] Instruções de caminhada
- [ ] Contador de paradas

### v1.0.0 (Release) - Semana 7-8
- [ ] Todos os recursos finalizados
- [ ] Testes completos
- [ ] Publicação nas lojas

---

## 👥 Equipe

### Core Team
- **Idealizador e Product Owner**: [Seu Nome]
- **Empresa**: Agaitecnology
- **Desenvolvimento**: [A definir]
- **Design**: [A definir]

### Contribuidores
[Lista será atualizada conforme projeto cresce]

---

## 📄 Licença

Este projeto está sob licença [MIT/Proprietária - definir].

Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---

## 📞 Contato e Suporte

### Canais Oficiais
- **Email**: contato@agaitecnology.com
- **GitHub**: [@agaitecnology](https://github.com/agaitecnology)
- **Issues**: [GitHub Issues](https://github.com/agaitecnology/vodibus-app/issues)

### Como Contribuir
Leia nosso [CONTRIBUTING.md](docs/CONTRIBUTING.md) para saber como ajudar!

---

## 🙏 Agradecimentos

- Agradecimento especial aos idosos participantes da validação na UBS
- Comunidade Flutter Brasil
- Todos que acreditam em tecnologia acessível para todos

---

## 📸 Screenshots

### Mockup v3.0 - Telas Principais

| Splash | Home | OCR |
|--------|------|-----|
| ![Splash](docs/screenshots/splash.png) | ![Home](docs/screenshots/home.png) | ![OCR](docs/screenshots/ocr.png) |

| Resultados | Navegação | No Ônibus |
|------------|-----------|-----------|
| ![Resultados](docs/screenshots/resultados.png) | ![Navegação](docs/screenshots/navegacao.png) | ![OnBus](docs/screenshots/onibus.png) |

---

## 🌟 Por que VoDiBus!?

> *"Porque andar de ônibus não deveria ser complicado.  
> Porque tecnologia deve incluir, não excluir.  
> Porque todo mundo merece mobilidade com dignidade."*

---

*Desenvolvido com ❤️ em São José do Rio Preto, SP*  
*Agaitecnology - Tecnologia que conecta pessoas*

---

**Última atualização**: 05 de Abril de 2026  
**Versão do README**: 1.0.0
