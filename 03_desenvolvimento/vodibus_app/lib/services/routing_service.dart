import 'package:vodibus_app/models/stop.dart';
import 'package:vodibus_app/models/route.dart';
import 'package:vodibus_app/services/transit_service.dart';

class RotaRecomendada {
  final Route linha;
  final Stop paradaEmbarque;
  final double distanciaApeKm;
  final int tempoApeMin;
  final String proximoHorario;
  final int tempoEsperaMin;

  const RotaRecomendada({
    required this.linha,
    required this.paradaEmbarque,
    required this.distanciaApeKm,
    required this.tempoApeMin,
    required this.proximoHorario,
    required this.tempoEsperaMin,
  });

  int get tempoTotalMin => tempoApeMin + tempoEsperaMin;
}

class RoutingService {
  static Future<List<RotaRecomendada>> encontrarMelhorRota({
    required double userLat,
    required double userLon,
    required String destino,
  }) async {
    final List<RotaRecomendada> opcoes = [];

    for (final linha in Route.linhasRioPreto) {
      final paradas = await TransitService.buscarParadasDaLinha(linha.routeId);
      if (paradas.isEmpty) continue;

      Stop? paradaMaisProxima;
      double menorDistancia = double.infinity;

      for (final parada in paradas) {
        final distancia = TransitService.calcularDistanciaKm(
          userLat,
          userLon,
          parada.stopLat,
          parada.stopLon,
        );
        if (distancia < menorDistancia) {
          menorDistancia = distancia;
          paradaMaisProxima = parada;
        }
      }

      if (paradaMaisProxima == null) continue;
      if (menorDistancia > 1.5) continue;

      final tempoApe = (menorDistancia / 5.0 * 60).round();
      final proximoHorario = _simularProximoHorario();
      final tempoEspera = _simularTempoEspera();

      opcoes.add(
        RotaRecomendada(
          linha: linha,
          paradaEmbarque: paradaMaisProxima,
          distanciaApeKm: menorDistancia,
          tempoApeMin: tempoApe,
          proximoHorario: proximoHorario,
          tempoEsperaMin: tempoEspera,
        ),
      );
    }

    opcoes.sort((a, b) => a.tempoTotalMin.compareTo(b.tempoTotalMin));
    return opcoes.take(3).toList();
  }

  static String _simularProximoHorario() {
    final agora = DateTime.now();
    final proximo = agora.add(Duration(minutes: 5 + (agora.minute % 15)));
    return '${proximo.hour.toString().padLeft(2, '0')}:'
        '${proximo.minute.toString().padLeft(2, '0')}';
  }

  static int _simularTempoEspera() {
    final agora = DateTime.now();
    return 5 + (agora.minute % 15);
  }
}
