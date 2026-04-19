import 'package:flutter/material.dart';
import 'package:vodibus_app/theme/app_colors.dart';
import 'package:vodibus_app/models/trip.dart';
import 'package:vodibus_app/services/transit_service.dart';
import 'package:vodibus_app/screens/trip_screen.dart';
import 'package:vodibus_app/screens/walking_screen.dart';

class DetalheScreen extends StatefulWidget {
  final String numero;
  final String nome;

  const DetalheScreen({super.key, required this.numero, required this.nome});

  @override
  State<DetalheScreen> createState() => _DetalheScreenState();
}

class _DetalheScreenState extends State<DetalheScreen> {
  List<StopTime> _paradas = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _buscarViagens();
  }

  Future<void> _buscarViagens() async {
    final viagens = await TransitService.buscarViagens(widget.numero);
    if (!mounted) return;
    setState(() {
      _paradas = viagens.isNotEmpty ? viagens.first.stopTimes : [];
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
          'Linha ${widget.numero}',
          style: const TextStyle(
            color: AppColors.branco,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.branco),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: AppColors.azulEscuro,
            child: Text(
              widget.nome,
              style: const TextStyle(color: AppColors.branco, fontSize: 16),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.location_on, color: AppColors.azulMedio),
                SizedBox(width: 8),
                Text(
                  'Paradas da linha',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.azulEscuro,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _carregando
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.azulMedio,
                    ),
                  )
                : _paradas.isEmpty
                ? const Center(
                    child: Text(
                      'Paradas não disponíveis',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.cinzaTexto,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _paradas.length,
                    itemBuilder: (context, index) {
                      final parada = _paradas[index];
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                decoration: const BoxDecoration(
                                  color: AppColors.azulMedio,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              if (index < _paradas.length - 1)
                                Container(
                                  width: 2,
                                  height: 56,
                                  color: AppColors.azulMedio,
                                ),
                            ],
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 24),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      parada.stopName,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.textoPrincipal,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    parada.arrivalTime.substring(0, 5),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: AppColors.verde,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
          ),

          // Botões de ação
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => WalkingScreen(destino: widget.nome),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.azulMedio,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    icon: const Icon(
                      Icons.directions_walk,
                      color: AppColors.branco,
                    ),
                    label: const Text(
                      'Como chegar ao ponto',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.branco,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TripScreen(
                            numeroLinha: widget.numero,
                            nomeLinha: widget.nome,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.verde,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    icon: const Icon(
                      Icons.directions_bus,
                      color: AppColors.branco,
                    ),
                    label: const Text(
                      'Embarcar nesta linha',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.branco,
                      ),
                    ),
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
