// Espelha trips.txt e stop_times.txt do padrão GTFS
class StopTime {
  final String tripId;
  final String arrivalTime;
  final String departureTime;
  final String stopId;
  final String stopName;
  final int stopSequence;

  const StopTime({
    required this.tripId,
    required this.arrivalTime,
    required this.departureTime,
    required this.stopId,
    required this.stopName,
    required this.stopSequence,
  });

  factory StopTime.fromJson(Map<String, dynamic> json) {
    return StopTime(
      tripId: json['trip_id'] ?? '',
      arrivalTime: json['arrival_time'] ?? '',
      departureTime: json['departure_time'] ?? '',
      stopId: json['stop_id'] ?? '',
      stopName: json['stop_name'] ?? '',
      stopSequence: int.tryParse(json['stop_sequence'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'trip_id': tripId,
    'arrival_time': arrivalTime,
    'departure_time': departureTime,
    'stop_id': stopId,
    'stop_name': stopName,
    'stop_sequence': stopSequence,
  };
}

class Trip {
  final String tripId;
  final String routeId;
  final String serviceId;
  final String tripHeadsign;
  final int directionId;
  final List<StopTime> stopTimes;

  const Trip({
    required this.tripId,
    required this.routeId,
    required this.serviceId,
    required this.tripHeadsign,
    required this.directionId,
    required this.stopTimes,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    final stopTimesList = (json['stop_times'] as List<dynamic>? ?? [])
        .map((s) => StopTime.fromJson(s))
        .toList();

    return Trip(
      tripId: json['trip_id'] ?? '',
      routeId: json['route_id'] ?? '',
      serviceId: json['service_id'] ?? '',
      tripHeadsign: json['trip_headsign'] ?? '',
      directionId: int.tryParse(json['direction_id'].toString()) ?? 0,
      stopTimes: stopTimesList,
    );
  }

  Map<String, dynamic> toJson() => {
    'trip_id': tripId,
    'route_id': routeId,
    'service_id': serviceId,
    'trip_headsign': tripHeadsign,
    'direction_id': directionId,
    'stop_times': stopTimes.map((s) => s.toJson()).toList(),
  };

  // Viagens mockadas — linha 101 Rio Preto
  static final List<Trip> viagensMockadas = [
    Trip(
      tripId: '101-1',
      routeId: '101',
      serviceId: 'dias_uteis',
      tripHeadsign: 'Terminal Norte',
      directionId: 0,
      stopTimes: [
        const StopTime(
          tripId: '101-1',
          arrivalTime: '08:15:00',
          departureTime: '08:15:00',
          stopId: 'TCP001',
          stopName: 'Terminal Central',
          stopSequence: 1,
        ),
        const StopTime(
          tripId: '101-1',
          arrivalTime: '08:22:00',
          departureTime: '08:22:00',
          stopId: 'S002',
          stopName: 'Praça Rui Barbosa',
          stopSequence: 2,
        ),
        const StopTime(
          tripId: '101-1',
          arrivalTime: '08:28:00',
          departureTime: '08:28:00',
          stopId: 'S003',
          stopName: 'Av. Bady Bassitt',
          stopSequence: 3,
        ),
        const StopTime(
          tripId: '101-1',
          arrivalTime: '08:35:00',
          departureTime: '08:35:00',
          stopId: 'S004',
          stopName: 'Hospital de Base',
          stopSequence: 4,
        ),
        const StopTime(
          tripId: '101-1',
          arrivalTime: '08:42:00',
          departureTime: '08:42:00',
          stopId: 'S005',
          stopName: 'Shopping Iguatemi',
          stopSequence: 5,
        ),
        const StopTime(
          tripId: '101-1',
          arrivalTime: '08:50:00',
          departureTime: '08:50:00',
          stopId: 'S006',
          stopName: 'Terminal Norte',
          stopSequence: 6,
        ),
      ],
    ),
  ];
}
