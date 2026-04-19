import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vodibus_app/theme/app_colors.dart';
import 'package:vodibus_app/services/location_service.dart';
import 'package:vodibus_app/screens/resultados_screen.dart';

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
      final endereco = await LocationService.obterEndereco(
        posicao.latitude,
        posicao.longitude,
      );
      status =
          (endereco == 'Endereço não disponível' ||
              endereco == 'Endereço não encontrado')
          ? LocationService.formatarCoordenadas(posicao)
          : endereco;
    }

    if (!mounted) return;
    setState(() {
      _posicao = posicao;
      _carregandoGPS = false;
      _statusGPS = status;
    });
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
                    // Card GPS
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.branco,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          _carregandoGPS
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.azulMedio,
                                  ),
                                )
                              : Icon(
                                  _posicao != null
                                      ? Icons.location_on
                                      : Icons.location_off,
                                  color: _posicao != null
                                      ? AppColors.azulMedio
                                      : Colors.red,
                                  size: 24,
                                ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _posicao != null
                                      ? 'Você está aqui'
                                      : 'GPS indisponível',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textoPrincipal,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _statusGPS,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.cinzaTexto,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (_posicao != null)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.verdeAzulado,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                '✓ GPS',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.azulEscuro,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Card destino
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.branco,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Para onde você quer ir?',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.cinzaTexto,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _controller,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textoPrincipal,
                                  ),
                                  decoration: const InputDecoration(
                                    hintText: 'Digite o destino',
                                    hintStyle: TextStyle(
                                      color: AppColors.cinzaClaro,
                                      fontSize: 22,
                                    ),
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ),
                              ),
                              Container(
                                width: 44,
                                height: 44,
                                decoration: const BoxDecoration(
                                  color: AppColors.azulMedio,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.mic,
                                  color: AppColors.branco,
                                  size: 22,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Botão buscar
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_controller.text.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ResultadosScreen(
                                  destino: _controller.text,
                                  posicao: _posicao,
                                ),
                              ),
                            );
                          }
                        },
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

                    // Linhas populares
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
                    _cartaoLinha('101', 'Centro — Terminal Norte', '08:15'),
                    _cartaoLinha('204', 'Bairro Sul — Centro', '08:22'),
                    _cartaoLinha('310', 'Terminal Leste — Shopping', '08:30'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cartaoLinha(String numero, String nome, String horario) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.branco,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.azulEscuro,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                numero,
                style: const TextStyle(
                  color: AppColors.branco,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nome,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textoPrincipal,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Próximo: $horario',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.verde,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: AppColors.azulMedio,
          ),
        ],
      ),
    );
  }
}
