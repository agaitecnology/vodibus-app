import 'package:vodibus_app/models/stop.dart';
import 'package:vodibus_app/models/route.dart';
import 'package:vodibus_app/services/transit_service.dart';

class RotaRecomendada {
  final Route linha;
  final Stop paradaEmbarque;
  final Stop? paradaDestino;
  final double distanciaApeKm;
  final int tempoApeMin;
  final String proximoHorario;
  final int tempoEsperaMin;
  final double relevancia;

  const RotaRecomendada({
    required this.linha,
    required this.paradaEmbarque,
    this.paradaDestino,
    required this.distanciaApeKm,
    required this.tempoApeMin,
    required this.proximoHorario,
    required this.tempoEsperaMin,
    required this.relevancia,
  });

  int get tempoTotalMin => tempoApeMin + tempoEsperaMin;
}

class RoutingService {
  // Palavras-chave para matching de destinos
  static const Map<String, List<String>> _destinosPorLinha = {
    '101': [
      'terminal norte',
      'norte',
      'centro',
      'praça rui barbosa',
      'bady bassitt',
      'hospital de base',
      'hospital',
      'base',
      'shopping iguatemi',
      'iguatemi',
      'shopping',
    ],
    '204': [
      'pq cidadania',
      'cidadania',
      'parque cidadania',
      'centro',
      'philadélfia',
      'brigadeiro',
      'terminal central',
    ],
    '305': [
      'josé munia',
      'munia',
      'jd paulista',
      'paulista',
      'andreazza',
      'centro',
      'terminal central',
    ],
    '214': [
      'mirassolândia',
      'jd nazareth',
      'nazareth',
      'ressaca',
      'centro',
      'terminal central',
    ],
    '702': [
      'nova esperança',
      'esperança',
      'dist industrial',
      'industrial',
      'oeste',
    ],
    '110': ['carlos arnaldo', 'arnaldo', 'centro'],
    '215': ['ulisses guimarães', 'dist industrial', 'industrial', 'centro'],
    '307': ['jd tarraf', 'tarraf', 'centro'],
    '308': ['jd maracanã', 'maracanã', 'centro'],
    '206': ['jd nunes', 'nunes', 'centro'],
    '208': ['são jorge', 'res america', 'america', 'centro'],
    '122': ['solidariedade', 'res america', 'america', 'centro'],
    '410A': ['eng schmitt', 'schmitt', 'represa', 'centro'],
    '410B': ['eng schmitt', 'schmitt', 'washington luis', 'centro'],
  };

  static Future<List<RotaRecomendada>> encontrarMelhorRota({
    required double userLat,
    required double userLon,
    required String destino,
  }) async {
    final List<RotaRecomendada> opcoes = [];
    final termoDestino = destino
        .toLowerCase()
        .replaceAll('avenida', 'av')
        .replaceAll('rua', '')
        .trim();

    for (final linha in Route.linhasRioPreto) {
      final paradas = await TransitService.buscarParadasDaLinha(linha.routeId);
      if (paradas.isEmpty) continue;

      // Calcula relevância da linha para o destino
      final relevancia = _calcularRelevancia(linha.routeId, termoDestino);

      // Ignora linhas sem relevância mínima
      if (relevancia < 0.1) continue;

      // Encontra parada mais próxima do usuário
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
      if (menorDistancia > 2.0) continue;

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
          relevancia: relevancia,
        ),
      );
    }

    // Ordena por relevância primeiro, depois por tempo total
    opcoes.sort((a, b) {
      final diffRelevancia = b.relevancia.compareTo(a.relevancia);
      if (diffRelevancia != 0) return diffRelevancia;
      return a.tempoTotalMin.compareTo(b.tempoTotalMin);
    });

    return opcoes.take(3).toList();
  }

  static double _calcularRelevancia(String routeId, String destino) {
    final keywords = _destinosPorLinha[routeId] ?? [];
    if (keywords.isEmpty) return 0.1;

    double melhorScore = 0.0;

    for (final keyword in keywords) {
      if (destino.contains(keyword)) {
        // Match exato — alta relevância
        melhorScore = 1.0;
        break;
      }
      // Match parcial — relevância proporcional
      final palavras = keyword.split(' ');
      for (final palavra in palavras) {
        if (palavra.length > 3 && destino.contains(palavra)) {
          final score = palavra.length / keyword.length;
          if (score > melhorScore) melhorScore = score;
        }
      }
    }

    // Se não encontrou nada relevante retorna score baixo
    return melhorScore > 0 ? melhorScore : 0.1;
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
