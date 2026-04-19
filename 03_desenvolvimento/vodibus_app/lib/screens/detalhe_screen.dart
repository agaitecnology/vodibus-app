import 'package:flutter/material.dart';
import 'package:vodibus_app/theme/app_colors.dart';
import 'package:vodibus_app/screens/trip_screen.dart';
import 'package:vodibus_app/screens/walking_screen.dart';

class DetalheScreen extends StatelessWidget {
  final String numero;
  final String nome;

  const DetalheScreen({super.key, required this.numero, required this.nome});

  final List<Map<String, String>> _paradas = const [
    {'parada': 'Terminal Central', 'horario': '08:15'},
    {'parada': 'Praça da Sé', 'horario': '08:22'},
    {'parada': 'Av. Principal', 'horario': '08:28'},
    {'parada': 'Hospital Municipal', 'horario': '08:35'},
    {'parada': 'Shopping Center', 'horario': '08:42'},
    {'parada': 'Terminal Norte', 'horario': '08:50'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cinzaFundo,
      appBar: AppBar(
        backgroundColor: AppColors.azulEscuro,
        title: Text(
          'Linha $numero',
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
              nome,
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
            child: ListView.builder(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              parada['parada']!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textoPrincipal,
                              ),
                            ),
                            Text(
                              parada['horario']!,
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
                          builder: (_) => WalkingScreen(destino: nome),
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
                          builder: (_) =>
                              TripScreen(numeroLinha: numero, nomeLinha: nome),
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
