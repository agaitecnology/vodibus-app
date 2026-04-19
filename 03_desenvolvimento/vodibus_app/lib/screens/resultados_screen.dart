import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vodibus_app/theme/app_colors.dart';
import 'detalhe_screen.dart';

class ResultadosScreen extends StatelessWidget {
  final String destino;
  final Position? posicao;

  const ResultadosScreen({super.key, required this.destino, this.posicao});

  final List<Map<String, String>> _linhas = const [
    {'numero': '101', 'nome': 'Centro — Terminal Norte', 'horario': '08:15'},
    {'numero': '204', 'nome': 'Bairro Sul — Centro', 'horario': '08:22'},
    {'numero': '310', 'nome': 'Terminal Leste — Shopping', 'horario': '08:30'},
    {'numero': '415', 'nome': 'Vila Nova — Centro', 'horario': '08:45'},
    {'numero': '502', 'nome': 'Centro — Aeroporto', 'horario': '09:00'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cinzaFundo,
      appBar: AppBar(
        backgroundColor: AppColors.azulEscuro,
        title: Text(
          'Ônibus para: $destino',
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
          // Indicador GPS
          if (posicao != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: AppColors.verdeAzulado,
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: AppColors.azulEscuro,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Lat: ${posicao!.latitude.toStringAsFixed(4)}, '
                    'Lng: ${posicao!.longitude.toStringAsFixed(4)}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.azulEscuro,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

          // Lista de linhas
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _linhas.length,
              itemBuilder: (context, index) {
                final linha = _linhas[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetalheScreen(
                          numero: linha['numero']!,
                          nome: linha['nome']!,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.branco,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: AppColors.azulEscuro,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              linha['numero']!,
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
                                linha['nome']!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textoPrincipal,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Próximo: ${linha['horario']}',
                                style: const TextStyle(
                                  fontSize: 14,
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
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
