// Espelha stops.txt do padrão GTFS
class Stop {
  final String stopId;
  final String stopName;
  final double stopLat;
  final double stopLon;
  final String? stopDesc;
  final String? zoneId;

  const Stop({
    required this.stopId,
    required this.stopName,
    required this.stopLat,
    required this.stopLon,
    this.stopDesc,
    this.zoneId,
  });

  factory Stop.fromJson(Map<String, dynamic> json) {
    return Stop(
      stopId: json['stop_id'] ?? '',
      stopName: json['stop_name'] ?? '',
      stopLat: double.tryParse(json['stop_lat'].toString()) ?? 0.0,
      stopLon: double.tryParse(json['stop_lon'].toString()) ?? 0.0,
      stopDesc: json['stop_desc'],
      zoneId: json['zone_id'],
    );
  }

  Map<String, dynamic> toJson() => {
    'stop_id': stopId,
    'stop_name': stopName,
    'stop_lat': stopLat,
    'stop_lon': stopLon,
    'stop_desc': stopDesc,
    'zone_id': zoneId,
  };

  // Paradas reais do Terminal Central — Rio Preto
  static const List<Stop> terminalCentral = [
    Stop(
      stopId: 'TCP001',
      stopName: 'Terminal Central — Plataforma A',
      stopLat: -20.8197,
      stopLon: -49.3794,
    ),
    Stop(
      stopId: 'TCP002',
      stopName: 'Terminal Central — Plataforma B',
      stopLat: -20.8199,
      stopLon: -49.3792,
    ),
    Stop(
      stopId: 'TCP003',
      stopName: 'Terminal Central — Plataforma C',
      stopLat: -20.8201,
      stopLon: -49.3790,
    ),
  ];
}
