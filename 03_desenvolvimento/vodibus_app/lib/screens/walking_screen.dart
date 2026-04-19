import 'package:flutter/material.dart';
import 'package:vodibus_app/theme/app_colors.dart';

class WalkingScreen extends StatelessWidget {
  final String destino;

  const WalkingScreen({super.key, required this.destino});

  final List<Map<String, String>> _instrucoes = const [
    {'icone': '↑', 'texto': 'Siga em frente pela rua principal'},
    {'icone': '→', 'texto': 'Vire à direita na próxima esquina'},
    {'icone': '↑', 'texto': 'Ande 200 metros até o semáforo'},
    {'icone': '←', 'texto': 'Vire à esquerda na Rua Voluntários'},
    {'icone': '📍', 'texto': 'O ponto está à sua frente'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cinzaFundo,
      appBar: AppBar(
        backgroundColor: AppColors.azulEscuro,
        title: const Text(
          'Como chegar ao ponto',
          style: TextStyle(
            color: AppColors.branco,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.branco),
      ),
      body: Column(
        children: [
          // Destino
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.azulMedio, Color(0xFF0051D5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: AppColors.amarelo,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Seu destino',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      Text(
                        destino,
                        style: const TextStyle(
                          color: AppColors.branco,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Tempo estimado
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            color: AppColors.verdeAzulado,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      '5 min',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.azulEscuro,
                      ),
                    ),
                    Text(
                      'a pé',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.cinzaTexto,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '400m',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.azulEscuro,
                      ),
                    ),
                    Text(
                      'distância',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.cinzaTexto,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Instruções
          const Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.directions_walk, color: AppColors.azulMedio),
                SizedBox(width: 8),
                Text(
                  'Instruções',
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
              itemCount: _instrucoes.length,
              itemBuilder: (context, index) {
                final instrucao = _instrucoes[index];
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
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.azulEscuro,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            instrucao['icone']!,
                            style: const TextStyle(
                              fontSize: 22,
                              color: AppColors.branco,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          instrucao['texto']!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textoPrincipal,
                          ),
                        ),
                      ),
                    ],
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
