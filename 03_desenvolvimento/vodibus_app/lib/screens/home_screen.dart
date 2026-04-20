import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vodibus_app/theme/app_colors.dart';
import 'package:vodibus_app/services/location_service.dart';
import 'package:vodibus_app/services/voice_service.dart';
import 'package:vodibus_app/screens/resultados_screen.dart';
import 'package:vodibus_app/screens/ocr_screen.dart';
import 'package:vodibus_app/widgets/card_gps.dart';
import 'package:vodibus_app/widgets/card_destino.dart';
import 'package:vodibus_app/widgets/card_linha_popular.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  Position? _posicao;
  String _statusGPS = 'Localizando...';
  bool _carregandoGPS = true;
  bool _escutando = false;

  @override
  void initState() {
    super.initState();
    _iniciarGPS();
    _controller.addListener(() => setState(() {}));
  }

  Future<void> _iniciarGPS() async {
    final posicao = await LocationService.obterLocalizacao();
    if (!mounted) return;

    String status = 'Localização não disponível';
    if (posicao != null) {
      status = await LocationService.obterEndereco(
        posicao.latitude,
        posicao.longitude,
      );
    }

    if (!mounted) return;
    setState(() {
      _posicao = posicao;
      _carregandoGPS = false;
      _statusGPS = status;
    });
  }

  // Entrada 1 — Digitar
  Future<void> _abrirDigitacao() async {
    final texto = await showDialog<String>(
      context: context,
      builder: (context) {
        final ctrl = TextEditingController();
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Row(
            children: [
              Icon(Icons.keyboard, color: AppColors.azulMedio, size: 28),
              SizedBox(width: 8),
              Text(
                'Digite o destino',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.azulEscuro,
                ),
              ),
            ],
          ),
          content: TextField(
            controller: ctrl,
            autofocus: true,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.textoPrincipal,
            ),
            decoration: InputDecoration(
              hintText: 'Ex: Hospital de Base',
              hintStyle: const TextStyle(color: AppColors.cinzaClaro),
              filled: true,
              fillColor: AppColors.verdeAzulado,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            onSubmitted: (v) => Navigator.pop(context, v),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context, ctrl.text),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.azulMedio,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.check_circle, color: AppColors.branco),
                label: const Text(
                  'Confirmar',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.branco,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
    if (texto != null && texto.isNotEmpty) {
      await _mostrarDialogoConfirmacao(texto);
    }
  }

  // Entrada 2 — Falar
  Future<void> _ativarMicrofone() async {
    if (_escutando) {
      await VoiceService.parar();
      setState(() => _escutando = false);
      return;
    }

    setState(() => _escutando = true);

    await VoiceService.ouvir(
      onResultado: (texto) async {
        setState(() => _escutando = false);
        if (!mounted) return;
        await _mostrarDialogoConfirmacao(texto);
      },
      onFim: () => setState(() => _escutando = false),
    );
  }

  // Entrada 3 — Fotografar
  Future<void> _abrirCamera() async {
    final endereco = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const OcrScreen()),
    );
    if (endereco != null && endereco.isNotEmpty) {
      await _mostrarDialogoConfirmacao(endereco);
    }
  }

  // Diálogo de confirmação — igual para as 3 entradas
  Future<void> _mostrarDialogoConfirmacao(String texto) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.location_on, color: AppColors.azulMedio, size: 28),
            SizedBox(width: 8),
            Text(
              'Destino:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.azulEscuro,
              ),
            ),
          ],
        ),
        content: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.verdeAzulado,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            texto,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.azulEscuro,
            ),
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.cinzaTexto,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.arrow_back, color: AppColors.branco),
              label: const Text(
                'Corrigir',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.branco,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                setState(() => _controller.text = texto);
                _buscarOnibus(texto);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.verde,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.directions_bus, color: AppColors.branco),
              label: const Text(
                'Buscar ônibus!',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.branco,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _buscarOnibus(String destino) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResultadosScreen(destino: destino, posicao: _posicao),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cinzaFundo,
      body: SafeArea(
        child: Column(
          children: [
            // Boas-vindas
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.azulMedio, Color(0xFF0051D5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Oi! Para onde você quer ir hoje?',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.branco,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Vamos te ajudar a chegar lá 😊',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    CardGps(
                      carregando: _carregandoGPS,
                      posicao: _posicao,
                      statusGPS: _statusGPS,
                    ),
                    const SizedBox(height: 12),

                    CardDestino(
                      controller: _controller,
                      escutando: _escutando,
                      onDigitar: _abrirDigitacao,
                      onMicrofone: _ativarMicrofone,
                      onCamera: _abrirCamera,
                    ),
                    const SizedBox(height: 24),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Linhas populares',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.azulEscuro,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    CardLinhaPopular(
                      numero: '101',
                      nome: 'Centro — Terminal Norte',
                      horario: '08:15',
                    ),
                    CardLinhaPopular(
                      numero: '204',
                      nome: 'Pq. Cidadania — Centro',
                      horario: '08:22',
                    ),
                    CardLinhaPopular(
                      numero: '305',
                      nome: 'Av. José Munia — Centro',
                      horario: '08:30',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
