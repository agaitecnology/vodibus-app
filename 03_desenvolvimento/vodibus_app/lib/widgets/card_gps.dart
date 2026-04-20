import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vodibus_app/theme/app_colors.dart';

class CardGps extends StatelessWidget {
  final bool carregando;
  final Position? posicao;
  final String statusGPS;

  const CardGps({
    super.key,
    required this.carregando,
    required this.posicao,
    required this.statusGPS,
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
      child: Row(
        children: [
          carregando
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.azulMedio,
                  ),
                )
              : Icon(
                  posicao != null ? Icons.location_on : Icons.location_off,
                  color: posicao != null ? AppColors.azulMedio : Colors.red,
                  size: 24,
                ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  posicao != null ? 'Você está aqui' : 'GPS indisponível',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textoPrincipal,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  statusGPS,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.cinzaTexto,
                  ),
                ),
              ],
            ),
          ),
          if (posicao != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
    );
  }
}
