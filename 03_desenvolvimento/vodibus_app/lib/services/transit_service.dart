import 'package:vodibus_app/models/route.dart';
import 'package:vodibus_app/models/stop.dart';
import 'package:vodibus_app/models/trip.dart';
import 'package:vodibus_app/models/agency.dart';

// TransitService — arquitetura GTFS
// Hoje: dados mockados da RioPretrans
// Futuro: substituir _buscarLinhas() por chamada à API real
class TransitService {
  static final Agency _operadora = Agency.riopretrans;

  // Busca linhas por destino
  static Future<List<Route>> buscarLinhas(String destino) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final termo = destino.toLowerCase();
    return Route.linhasRioPreto.where((route) {
      return route.routeLongName.toLowerCase().contains(termo) ||
          route.routeShortName.contains(termo);
    }).toList();
  }

  // Retorna todas as linhas
  static Future<List<Route>> listarTodasLinhas() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return Route.linhasRioPreto;
  }

  // Busca viagens de uma linha
  static Future<List<Trip>> buscarViagens(String routeId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return Trip.viagensMockadas
        .where((trip) => trip.routeId == routeId)
        .toList();
  }

  // Busca paradas próximas por coordenadas
  static Future<List<Stop>> buscarParadasProximas(
    double lat,
    double lon, {
    double raioKm = 0.5,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return Stop.terminalCentral.where((stop) {
      final distancia = _calcularDistancia(
        lat,
        lon,
        stop.stopLat,
        stop.stopLon,
      );
      return distancia <= raioKm;
    }).toList();
  }

  // Retorna informações da operadora
  static Agency get operadora => _operadora;

  // Cálculo de distância em km (fórmula Haversine simplificada)
  static double _calcularDistancia(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const double raioTerra = 6371;
    final dLat = _toRad(lat2 - lat1);
    final dLon = _toRad(lon2 - lon1);
    final a = (dLat / 2) * (dLat / 2) + (dLon / 2) * (dLon / 2);
    final c = 2 * (a < 1 ? a : 1);
    return raioTerra * c;
  }

  static double _toRad(double deg) => deg * 0.017453292519943295;
}
