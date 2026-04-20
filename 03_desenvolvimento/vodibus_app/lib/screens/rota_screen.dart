import 'package:flutter/material.dart';
import 'package:vodibus_app/theme/app_colors.dart';
import 'package:vodibus_app/services/routing_service.dart';
import 'package:vodibus_app/screens/walking_screen.dart';
import 'package:vodibus_app/screens/detalhe_screen.dart';

class RotaScreen extends StatefulWidget {
  final String destino;
  final double userLat;
  final double userLon;

  const RotaScreen({
    super.key,
    required this.destino,
    required this.userLat,
    required this.userLon,
  });

  @override
  State<RotaScreen> createState() => _RotaScreenState();
}

class _RotaScreenState extends State<RotaScreen> {
  List<RotaRecomendada> _rotas = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _buscarRotas();
  }

  Future<void> _buscarRotas() async {
    final rotas = await RoutingService.encontrarMelhorRota(
      userLat: widget.userLat,
      userLon: widget.userLon,
      destino: widget.destino,
    );
    if (!mounted) return;
    setState(() {
      _rotas = rotas;
      _carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cinzaFundo,
      appBar: AppBar(
        backgroundColor: AppColors.azulEscuro,
        title: Text(
          'Como ir para: ${widget.destino}',
          style: const TextStyle(
            color: AppColors.branco,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        iconTheme: const IconThemeData(color: AppColors.branco),
      ),
      body: _carregando
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: AppColors.azulMedio),
                  SizedBox(height: 16),
                  Text(
                    'Buscando a melhor rota...',
                    style: TextStyle(fontSize: 16, color: AppColors.cinzaTexto),
                  ),
                ],
              ),
            )
          : _rotas.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.directions_bus_filled,
                    size: 80,
                    color: AppColors.cinzaClaro,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Nenhuma linha encontrada\npróxima à sua localização',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: AppColors.cinzaTexto),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.azulMedio,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Tentar novamente',
                      style: TextStyle(color: AppColors.branco),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _rotas.length,
              itemBuilder: (context, index) {
                final rota = _rotas[index];
                final melhor = index == 0;
                return _cardRota(rota, melhor);
              },
            ),
    );
  }

  Widget _cardRota(RotaRecomendada rota, bool melhor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.branco,
        borderRadius: BorderRadius.circular(20),
        border: melhor ? Border.all(color: AppColors.verde, width: 2) : null,
      ),
      child: Column(
        children: [
          // Cabeçalho
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: melhor ? AppColors.verde : AppColors.azulEscuro,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.branco,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    rota.linha.routeShortName,
                    style: TextStyle(
                      color: melhor ? AppColors.verde : AppColors.azulEscuro,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rota.linha.routeLongName,
                        style: const TextStyle(
                          color: AppColors.branco,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (melhor)
                        const Text(
                          '⭐ Melhor opção',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Detalhes
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _itemInfo(
                  icone: Icons.place,
                  cor: AppColors.azulMedio,
                  titulo: 'Embarque em',
                  valor: rota.paradaEmbarque.stopName,
                ),
                const Divider(),
                _itemInfo(
                  icone: Icons.directions_walk,
                  cor: AppColors.azulMedio,
                  titulo: 'A pé até o ponto',
                  valor:
                      '${(rota.distanciaApeKm * 1000).round()}m '
                      '— ${rota.tempoApeMin} min',
                ),
                const Divider(),
                _itemInfo(
                  icone: Icons.access_time,
                  cor: AppColors.verde,
                  titulo: 'Próximo ônibus',
                  valor:
                      '${rota.proximoHorario} '
                      '— em ${rota.tempoEsperaMin} min',
                ),
                const Divider(),
                _itemInfo(
                  icone: Icons.timer,
                  cor: AppColors.amarelo,
                  titulo: 'Tempo total estimado',
                  valor: '${rota.tempoTotalMin} minutos',
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => WalkingScreen(
                                destino: rota.paradaEmbarque.stopName,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.azulMedio,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(
                          Icons.directions_walk,
                          color: AppColors.branco,
                          size: 18,
                        ),
                        label: const Text(
                          'Como chegar',
                          style: TextStyle(
                            color: AppColors.branco,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetalheScreen(
                                numero: rota.linha.routeShortName,
                                nome: rota.linha.routeLongName,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.verde,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(
                          Icons.directions_bus,
                          color: AppColors.branco,
                          size: 18,
                        ),
                        label: const Text(
                          'Embarcar',
                          style: TextStyle(
                            color: AppColors.branco,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemInfo({
    required IconData icone,
    required Color cor,
    required String titulo,
    required String valor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icone, color: cor, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.cinzaTexto,
                  ),
                ),
                Text(
                  valor,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textoPrincipal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
