// Espelha agency.txt do padrão GTFS
class Agency {
  final String agencyId;
  final String agencyName;
  final String agencyUrl;
  final String agencyTimezone;
  final String? agencyPhone;

  const Agency({
    required this.agencyId,
    required this.agencyName,
    required this.agencyUrl,
    required this.agencyTimezone,
    this.agencyPhone,
  });

  // Dados reais da RioPretrans — São José do Rio Preto
  static const Agency riopretrans = Agency(
    agencyId: 'riopretrans',
    agencyName: 'Consórcio RioPretrans',
    agencyUrl: 'https://www.riopretrans.com.br',
    agencyTimezone: 'America/Sao_Paulo',
    agencyPhone: '(17) 3222-0000',
  );

  factory Agency.fromJson(Map<String, dynamic> json) {
    return Agency(
      agencyId: json['agency_id'] ?? '',
      agencyName: json['agency_name'] ?? '',
      agencyUrl: json['agency_url'] ?? '',
      agencyTimezone: json['agency_timezone'] ?? 'America/Sao_Paulo',
      agencyPhone: json['agency_phone'],
    );
  }

  Map<String, dynamic> toJson() => {
    'agency_id': agencyId,
    'agency_name': agencyName,
    'agency_url': agencyUrl,
    'agency_timezone': agencyTimezone,
    'agency_phone': agencyPhone,
  };
}
