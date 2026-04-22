import 'package:flutter/material.dart';
import 'package:vodibus_app/theme/app_colors.dart';

class WalkingScreen extends StatelessWidget {
  final String destino;
  final double? distanciaMetros;
  final int? tempoMinutos;
  final List<Map<String, String>>? instrucoes;

  const WalkingScreen({
    super.key,
    required this.destino,
    this.distanciaMetros,
    this.tempoMinutos,
    this.instrucoes,
  });

  List<Map<String, String>> get _instrucoesPadrao => [
    {'icone': '↑', 'texto': 'Saia em frente pela calçada'},
    {'icone': '→', 'texto': 'Vire à direita na próxima esquina'},
    {'icone': '↑', 'texto': 'Siga em frente por 200 metros'},
    {'icone': '←', 'texto': 'Vire à esquerda — o ponto está à sua frente'},
    {'icone': '📍', 'texto': 'Aguarde o ônibus neste ponto'},
  ];

  @override
  Widget build(BuildContext context) {
    final listaInstrucoes = instrucoes ?? _instrucoesPadrao;
    final distancia = distanciaMetros != null
        ? '${distanciaMetros!.round()}m'
        : '~400m';
    final tempo = tempoMinutos ?? 5;

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
                        'Ponto de embarque',
                        style: TextStyle(color: Colors.white70, fontSize: 13),
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

          // Tempo e distância
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            color: AppColors.verdeAzulado,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _itemResumo(
                  icone: Icons.timer,
                  valor: '$tempo min',
                  label: 'a pé',
                ),
                Container(width: 1, height: 40, color: AppColors.cinzaClaro),
                _itemResumo(
                  icone: Icons.straighten,
                  valor: distancia,
                  label: 'distância',
                ),
                Container(width: 1, height: 40, color: AppColors.cinzaClaro),
                _itemResumo(
                  icone: Icons.directions_walk,
                  valor: 'Devagar',
                  label: 'ritmo',
                ),
              ],
            ),
          ),

          // Instrucoes
          const Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.directions_walk, color: AppColors.azulMedio),
                SizedBox(width: 8),
                Text(
                  'Passo a passo',
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
              itemCount: listaInstrucoes.length,
              itemBuilder: (context, index) {
                final instrucao = listaInstrucoes[index];
                final ultimo = index == listaInstrucoes.length - 1;
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Linha do tempo
                    Column(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: ultimo
                                ? AppColors.verde
                                : AppColors.azulEscuro,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              instrucao['icone']!,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        if (!ultimo)
                          Container(
                            width: 2,
                            height: 40,
                            color: AppColors.cinzaClaro,
                          ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16, top: 8),
                        child: Text(
                          instrucao['texto']!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: ultimo
                                ? FontWeight.bold
                                : FontWeight.w500,
                            color: ultimo
                                ? AppColors.verde
                                : AppColors.textoPrincipal,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          // Botão iniciar
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.verde,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                icon: const Icon(Icons.check_circle, color: AppColors.branco),
                label: const Text(
                  'Entendido — vou ao ponto!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.branco,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemResumo({
    required IconData icone,
    required String valor,
    required String label,
  }) {
    return Column(
      children: [
        Icon(icone, color: AppColors.azulEscuro, size: 22),
        const SizedBox(height: 4),
        Text(
          valor,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.azulEscuro,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: AppColors.cinzaTexto),
        ),
      ],
    );
  }
}
