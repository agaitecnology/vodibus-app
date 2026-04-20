import 'package:flutter/material.dart';
import 'package:vodibus_app/theme/app_colors.dart';

class CardLinhaPopular extends StatelessWidget {
  final String numero;
  final String nome;
  final String horario;
  final VoidCallback? onTap;

  const CardLinhaPopular({
    super.key,
    required this.numero,
    required this.nome,
    required this.horario,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
      ),
    );
  }
}
