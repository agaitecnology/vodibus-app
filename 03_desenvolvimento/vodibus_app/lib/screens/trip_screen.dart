import 'package:flutter/material.dart';
import 'package:vodibus_app/theme/app_colors.dart';

class TripScreen extends StatefulWidget {
  final String numeroLinha;
  final String nomeLinha;

  const TripScreen({
    super.key,
    required this.numeroLinha,
    required this.nomeLinha,
  });

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  int _paradasRestantes = 5;
  bool _alerta = false;

  void _simularParada() {
    if (_paradasRestantes > 0) {
      setState(() {
        _paradasRestantes--;
        _alerta = _paradasRestantes <= 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _alerta ? Colors.red.shade50 : AppColors.cinzaFundo,
      appBar: AppBar(
        backgroundColor: AppColors.azulEscuro,
        title: Text(
          'Linha ${widget.numeroLinha}',
          style: const TextStyle(
            color: AppColors.branco,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.branco),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Nome da linha
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.azulEscuro,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                widget.nomeLinha,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.branco,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Contador de paradas
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: _alerta ? Colors.red : AppColors.azulMedio,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _alerta ? '⚠️ ATENÇÃO!' : 'Faltam',
                      style: const TextStyle(
                        color: AppColors.branco,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '$_paradasRestantes',
                      style: const TextStyle(
                        color: AppColors.branco,
                        fontSize: 96,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _paradasRestantes == 1 ? 'parada' : 'paradas',
                      style: const TextStyle(
                        color: AppColors.branco,
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _alerta ? 'DESÇA NA PRÓXIMA!' : 'até você descer',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.branco,
                        fontSize: _alerta ? 28 : 18,
                        fontWeight: _alerta
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Botão simular parada
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: _paradasRestantes > 0 ? _simularParada : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.amarelo,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                icon: const Icon(
                  Icons.directions_bus,
                  color: AppColors.azulEscuro,
                ),
                label: const Text(
                  'Simular próxima parada',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.azulEscuro,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
