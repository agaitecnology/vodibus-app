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

  Future<void> _ativarMicrofone() async {
    if (_escutando) {
      await VoiceService.parar();
      setState(() => _escutando = false);
      return;
    }
    setState(() => _escutando = true);
    await VoiceService.ouvir(
      onResultado: (texto) {
        setState(() {
          _controller.text = texto;
          _escutando = false;
        });
      },
      onFim: () => setState(() => _escutando = false),
    );
  }

  Future<void> _abrirCamera() async {
    final endereco = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const OcrScreen()),
    );
    if (endereco != null) {
      setState(() => _controller.text = endereco);
    }
  }

  void _buscarOnibus() {
    if (_controller.text.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              ResultadosScreen(destino: _controller.text, posicao: _posicao),
        ),
      );
    }
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
                    // Card GPS — componente separado
                    CardGps(
                      carregando: _carregandoGPS,
                      posicao: _posicao,
                      statusGPS: _statusGPS,
                    ),
                    const SizedBox(height: 12),

                    // Card destino — componente separado
                    CardDestino(
                      controller: _controller,
                      escutando: _escutando,
                      onMicrofone: _ativarMicrofone,
                      onCamera: _abrirCamera,
                      onBuscar: _buscarOnibus,
                    ),
                    const SizedBox(height: 16),

                    // Botão buscar
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: _buscarOnibus,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.azulMedio,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'Buscar ônibus',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.branco,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Linhas populares — componente separado
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
