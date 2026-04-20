// Espelha stops.txt do padrão GTFS
class Stop {
  final String stopId;
  final String stopName;
  final double stopLat;
  final double stopLon;
  final String? routeId;

  const Stop({
    required this.stopId,
    required this.stopName,
    required this.stopLat,
    required this.stopLon,
    this.routeId,
  });

  factory Stop.fromJson(Map<String, dynamic> json) {
    return Stop(
      stopId: json['stop_id'] ?? '',
      stopName: json['stop_name'] ?? '',
      stopLat: double.tryParse(json['stop_lat'].toString()) ?? 0.0,
      stopLon: double.tryParse(json['stop_lon'].toString()) ?? 0.0,
      routeId: json['route_id'],
    );
  }

  Map<String, dynamic> toJson() => {
    'stop_id': stopId,
    'stop_name': stopName,
    'stop_lat': stopLat,
    'stop_lon': stopLon,
    'route_id': routeId,
  };

  // Paradas reais de Rio Preto com coordenadas GPS
  static const List<Stop> paradasRioPreto = [
    // Linha 101 — Centro → Terminal Norte
    Stop(
      stopId: 'TCP001',
      stopName: 'Terminal Central',
      stopLat: -20.8197,
      stopLon: -49.3794,
      routeId: '101',
    ),
    Stop(
      stopId: 'S101_2',
      stopName: 'Praça Rui Barbosa',
      stopLat: -20.8180,
      stopLon: -49.3780,
      routeId: '101',
    ),
    Stop(
      stopId: 'S101_3',
      stopName: 'Av. Bady Bassitt',
      stopLat: -20.8150,
      stopLon: -49.3760,
      routeId: '101',
    ),
    Stop(
      stopId: 'S101_4',
      stopName: 'Hospital de Base',
      stopLat: -20.8100,
      stopLon: -49.3720,
      routeId: '101',
    ),
    Stop(
      stopId: 'S101_5',
      stopName: 'Shopping Iguatemi',
      stopLat: -20.8050,
      stopLon: -49.3680,
      routeId: '101',
    ),
    Stop(
      stopId: 'S101_6',
      stopName: 'Terminal Norte',
      stopLat: -20.7980,
      stopLon: -49.3640,
      routeId: '101',
    ),

    // Linha 204 — Pq. Cidadania → Centro
    Stop(
      stopId: 'S204_1',
      stopName: 'Pq. Cidadania',
      stopLat: -20.8350,
      stopLon: -49.3900,
      routeId: '204',
    ),
    Stop(
      stopId: 'S204_2',
      stopName: 'Av. Philadélfia',
      stopLat: -20.8300,
      stopLon: -49.3860,
      routeId: '204',
    ),
    Stop(
      stopId: 'S204_3',
      stopName: 'Av. Brigadeiro',
      stopLat: -20.8250,
      stopLon: -49.3820,
      routeId: '204',
    ),
    Stop(
      stopId: 'TCP001B',
      stopName: 'Terminal Central',
      stopLat: -20.8197,
      stopLon: -49.3794,
      routeId: '204',
    ),

    // Linha 305 — Av. José Munia → Centro
    Stop(
      stopId: 'S305_1',
      stopName: 'Av. José Munia',
      stopLat: -20.8420,
      stopLon: -49.3650,
      routeId: '305',
    ),
    Stop(
      stopId: 'S305_2',
      stopName: 'Jd. Paulista',
      stopLat: -20.8380,
      stopLon: -49.3700,
      routeId: '305',
    ),
    Stop(
      stopId: 'S305_3',
      stopName: 'Av. Alberto Andreazza',
      stopLat: -20.8320,
      stopLon: -49.3740,
      routeId: '305',
    ),
    Stop(
      stopId: 'TCP001C',
      stopName: 'Terminal Central',
      stopLat: -20.8197,
      stopLon: -49.3794,
      routeId: '305',
    ),

    // Linha 214 — Av. Mirassolândia → Centro
    Stop(
      stopId: 'S214_1',
      stopName: 'Av. Mirassolândia',
      stopLat: -20.8280,
      stopLon: -49.4050,
      routeId: '214',
    ),
    Stop(
      stopId: 'S214_2',
      stopName: 'Jd. Nazareth',
      stopLat: -20.8260,
      stopLon: -49.3980,
      routeId: '214',
    ),
    Stop(
      stopId: 'S214_3',
      stopName: 'Av. Ressaca',
      stopLat: -20.8230,
      stopLon: -49.3900,
      routeId: '214',
    ),
    Stop(
      stopId: 'TCP001D',
      stopName: 'Terminal Central',
      stopLat: -20.8197,
      stopLon: -49.3794,
      routeId: '214',
    ),

    // Linha 702 — Pq. Nova Esperança → Dist. Industrial
    Stop(
      stopId: 'S702_1',
      stopName: 'Pq. Nova Esperança',
      stopLat: -20.8450,
      stopLon: -49.3550,
      routeId: '702',
    ),
    Stop(
      stopId: 'S702_2',
      stopName: 'Av. Oeste',
      stopLat: -20.8400,
      stopLon: -49.3580,
      routeId: '702',
    ),
    Stop(
      stopId: 'S702_3',
      stopName: 'Dist. Industrial',
      stopLat: -20.8350,
      stopLon: -49.3500,
      routeId: '702',
    ),
  ];
}
