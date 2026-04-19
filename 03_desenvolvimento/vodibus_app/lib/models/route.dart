// Espelha routes.txt do padrão GTFS
class Route {
  final String routeId;
  final String agencyId;
  final String routeShortName;
  final String routeLongName;
  final int routeType;
  final String? routeColor;
  final String? routeTextColor;
  final String? routeDesc;

  const Route({
    required this.routeId,
    required this.agencyId,
    required this.routeShortName,
    required this.routeLongName,
    required this.routeType,
    this.routeColor,
    this.routeTextColor,
    this.routeDesc,
  });

  // routeType 3 = ônibus urbano (padrão GTFS)
  factory Route.fromJson(Map<String, dynamic> json) {
    return Route(
      routeId: json['route_id'] ?? '',
      agencyId: json['agency_id'] ?? 'riopretrans',
      routeShortName: json['route_short_name'] ?? '',
      routeLongName: json['route_long_name'] ?? '',
      routeType: int.tryParse(json['route_type'].toString()) ?? 3,
      routeColor: json['route_color'],
      routeTextColor: json['route_text_color'],
      routeDesc: json['route_desc'],
    );
  }

  Map<String, dynamic> toJson() => {
    'route_id': routeId,
    'agency_id': agencyId,
    'route_short_name': routeShortName,
    'route_long_name': routeLongName,
    'route_type': routeType,
    'route_color': routeColor,
    'route_text_color': routeTextColor,
    'route_desc': routeDesc,
  };

  // Linhas reais da RioPretrans — Rio Preto
  static const List<Route> linhasRioPreto = [
    Route(
      routeId: '101',
      agencyId: 'riopretrans',
      routeShortName: '101',
      routeLongName: 'Centro — Terminal Norte',
      routeType: 3,
    ),
    Route(
      routeId: '204',
      agencyId: 'riopretrans',
      routeShortName: '204',
      routeLongName: 'Pq. Cidadania — Centro',
      routeType: 3,
    ),
    Route(
      routeId: '305',
      agencyId: 'riopretrans',
      routeShortName: '305',
      routeLongName: 'Av. José Munia — Centro',
      routeType: 3,
    ),
    Route(
      routeId: '214',
      agencyId: 'riopretrans',
      routeShortName: '214',
      routeLongName: 'Av. Mirassolândia — Centro',
      routeType: 3,
    ),
    Route(
      routeId: '702',
      agencyId: 'riopretrans',
      routeShortName: '702',
      routeLongName: 'Pq. Nova Esperança — Dist. Industrial',
      routeType: 3,
    ),
  ];
}
