import 'package:flutter/material.dart';
import 'detalhe_screen.dart';

class ResultadosScreen extends StatelessWidget {
  final String destino;

  const ResultadosScreen({super.key, required this.destino});

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
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1565C0),
        title: Text(
          'Ônibus para: $destino',
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _linhas.length,
        itemBuilder: (context, index) {
          final linha = _linhas[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFF1565C0),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    linha['numero']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              title: Text(
                linha['nome']!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Próximo: ${linha['horario']}',
                style: const TextStyle(fontSize: 14, color: Colors.green),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFF1565C0),
              ),
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
            ),
          );
        },
      ),
    );
  }
}
