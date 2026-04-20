import 'package:flutter/material.dart';
import 'package:vodibus_app/theme/app_colors.dart';

class CardDestino extends StatelessWidget {
  final TextEditingController controller;
  final bool escutando;
  final VoidCallback onMicrofone;
  final VoidCallback onCamera;
  final VoidCallback onBuscar;

  const CardDestino({
    super.key,
    required this.controller,
    required this.escutando,
    required this.onMicrofone,
    required this.onCamera,
    required this.onBuscar,
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
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textoPrincipal,
                  ),
                  onSubmitted: (_) => onBuscar(),
                  decoration: const InputDecoration(
                    hintText: 'Digite, fale ou fotografe',
                    hintStyle: TextStyle(
                      color: AppColors.cinzaClaro,
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              // Botão microfone
              GestureDetector(
                onTap: onMicrofone,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: escutando ? Colors.red : AppColors.azulMedio,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    escutando ? Icons.stop : Icons.mic,
                    color: AppColors.branco,
                    size: 22,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Botão câmera OCR
              GestureDetector(
                onTap: onCamera,
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: AppColors.amarelo,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: AppColors.azulEscuro,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
          if (escutando)
            const Padding(
              padding: EdgeInsets.only(top: 12),
              child: Row(
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
}
