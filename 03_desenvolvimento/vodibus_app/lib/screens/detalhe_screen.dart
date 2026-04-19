import 'package:flutter/material.dart';

class DetalheScreen extends StatelessWidget {
  final String numero;
  final String nome;

  const DetalheScreen({super.key, required this.numero, required this.nome});

  final List<Map<String, String>> _paradas = const [
    {'parada': 'Terminal Central', 'horario': '08:15'},
    {'parada': 'Praça da Sé', 'horario': '08:22'},
    {'parada': 'Av. Principal', 'horario': '08:28'},
    {'parada': 'Hospital Municipal', 'horario': '08:35'},
    {'parada': 'Shopping Center', 'horario': '08:42'},
    {'parada': 'Terminal Norte', 'horario': '08:50'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1565C0),
        title: Text(
          'Linha $numero',
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: const Color(0xFF1565C0),
            child: Text(
              nome,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.location_on, color: Color(0xFF1565C0)),
                SizedBox(width: 8),
                Text(
                  'Paradas da linha',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1565C0),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _paradas.length,
              itemBuilder: (context, index) {
                final parada = _paradas[index];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: const BoxDecoration(
                            color: Color(0xFF1565C0),
                            shape: BoxShape.circle,
                          ),
                        ),
                        if (index < _paradas.length - 1)
                          Container(
                            width: 2,
                            height: 56,
                            color: const Color(0xFF1565C0),
                          ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              parada['parada']!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              parada['horario']!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
