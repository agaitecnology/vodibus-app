import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vodibus_app/theme/app_colors.dart';
import 'package:vodibus_app/models/route.dart' as transit;
import 'package:vodibus_app/services/transit_service.dart';
import 'detalhe_screen.dart';

class ResultadosScreen extends StatefulWidget {
  final String destino;
  final Position? posicao;

  const ResultadosScreen({super.key, required this.destino, this.posicao});

  @override
  State<ResultadosScreen> createState() => _ResultadosScreenState();
}

class _ResultadosScreenState extends State<ResultadosScreen> {
  List<transit.Route> _linhas = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _buscarLinhas();
  }

  Future<void> _buscarLinhas() async {
    final linhas = await TransitService.buscarLinhas(widget.destino);
    final todas = linhas.isEmpty
        ? await TransitService.listarTodasLinhas()
        : linhas;

    if (!mounted) return;
    setState(() {
      _linhas = todas;
      _carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cinzaFundo,
      appBar: AppBar(
        backgroundColor: AppColors.azulEscuro,
        title: Text(
          'Ônibus para: ${widget.destino}',
          style: const TextStyle(
            color: AppColors.branco,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.branco),
      ),
      body: Column(
        children: [
          // Indicador operadora
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            color: AppColors.verdeAzulado,
            child: Row(
              children: [
                const Icon(
                  Icons.directions_bus,
                  color: AppColors.azulEscuro,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  TransitService.operadora.agencyName,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.azulEscuro,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (posicao != null) ...[
                  const Spacer(),
                  const Icon(
                    Icons.location_on,
                    color: AppColors.azulEscuro,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'GPS ativo',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.azulEscuro,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Lista de linhas
          Expanded(
            child: _carregando
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.azulMedio,
                    ),
                  )
                : _linhas.isEmpty
                ? const Center(
                    child: Text(
                      'Nenhuma linha encontrada',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.cinzaTexto,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _linhas.length,
                    itemBuilder: (context, index) {
                      final linha = _linhas[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetalheScreen(
                                numero: linha.routeShortName,
                                nome: linha.routeLongName,
                              ),
                            ),
                          );
                        },
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
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  color: AppColors.azulEscuro,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    linha.routeShortName,
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
                                      linha.routeLongName,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textoPrincipal,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Tipo: ônibus urbano',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: AppColors.cinzaTexto,
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
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Position? get posicao => widget.posicao;
}
