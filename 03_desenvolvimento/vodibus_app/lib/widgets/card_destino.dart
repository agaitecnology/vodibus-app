import 'package:flutter/material.dart';
import 'package:vodibus_app/theme/app_colors.dart';

class CardDestino extends StatelessWidget {
  final TextEditingController controller;
  final bool escutando;
  final VoidCallback onDigitar;
  final VoidCallback onMicrofone;
  final VoidCallback onCamera;

  const CardDestino({
    super.key,
    required this.controller,
    required this.escutando,
    required this.onDigitar,
    required this.onMicrofone,
    required this.onCamera,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          const SizedBox(height: 16),

          // Três botões de entrada
          Row(
            children: [
              // Digite
              Expanded(
                child: _botaoEntrada(
                  icone: Icons.keyboard,
                  label: 'Digite',
                  cor: AppColors.azulEscuro,
                  onTap: onDigitar,
                ),
              ),
              const SizedBox(width: 8),
              // Fale
              Expanded(
                child: _botaoEntrada(
                  icone: escutando ? Icons.stop : Icons.mic,
                  label: escutando ? 'Ouvindo...' : 'Fale',
                  cor: escutando ? Colors.red : AppColors.azulMedio,
                  onTap: onMicrofone,
                ),
              ),
              const SizedBox(width: 8),
              // Fotografe
              Expanded(
                child: _botaoEntrada(
                  icone: Icons.camera_alt,
                  label: 'Fotografe',
                  cor: AppColors.amarelo,
                  corTexto: AppColors.azulEscuro,
                  onTap: onCamera,
                ),
              ),
            ],
          ),

          // Status microfone
          if (escutando)
            const Padding(
              padding: EdgeInsets.only(top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.graphic_eq, color: Colors.red, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Estou ouvindo... fale o destino',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _botaoEntrada({
    required IconData icone,
    required String label,
    required Color cor,
    Color corTexto = AppColors.branco,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: cor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icone, color: corTexto, size: 26),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: corTexto,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
