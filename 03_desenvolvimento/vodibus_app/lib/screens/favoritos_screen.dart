import 'package:flutter/material.dart';
import 'package:vodibus_app/theme/app_colors.dart';

class FavoritosScreen extends StatelessWidget {
  const FavoritosScreen({super.key});

  final List<Map<String, String>> _favoritos = const [
    {'numero': '101', 'nome': 'Centro — Terminal Norte'},
    {'numero': '204', 'nome': 'Bairro Sul — Centro'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cinzaFundo,
      appBar: AppBar(
        backgroundColor: AppColors.azulEscuro,
        title: const Text(
          'Meus Favoritos',
          style: TextStyle(
            color: AppColors.branco,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.branco),
      ),
      body: _favoritos.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star_border,
                    size: 80,
                    color: AppColors.cinzaClaro,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Nenhum favorito ainda',
                    style: TextStyle(fontSize: 18, color: AppColors.cinzaTexto),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _favoritos.length,
              itemBuilder: (context, index) {
                final item = _favoritos[index];
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
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: AppColors.azulEscuro,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            item['numero']!,
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
                        child: Text(
                          item['nome']!,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textoPrincipal,
                          ),
                        ),
                      ),
                      const Icon(Icons.star, color: AppColors.amarelo),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
