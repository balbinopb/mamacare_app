class HealthReport {
  final int dbpRot;
  final int dbpSupine;
  final int hr;
  final double mapRot;
  final double mapSupine;
  final int sbpRot;
  final int sbpSupine;
  final String mapStatus;
  final String riskLevel;

  HealthReport({
    required this.dbpRot,
    required this.dbpSupine,
    required this.hr,
    required this.mapRot,
    required this.mapSupine,
    required this.sbpRot,
    required this.sbpSupine,
    required this.mapStatus,
    required this.riskLevel,
  });

  // Factory constructor to parse from JSON
  factory HealthReport.fromJson(Map<String, dynamic> json) {
    return HealthReport(
      dbpRot: json['DBP_ROT'] as int,
      dbpSupine: json['DBP_Supine'] as int,
      hr: json['HR'] as int,
      mapRot: (json['MAP_ROT'] as num).toDouble(),
      mapSupine: (json['MAP_Supine'] as num).toDouble(),
      sbpRot: json['SBP_ROT'] as int,
      sbpSupine: json['SBP_Supine'] as int,
      mapStatus: json['mapStatus'] as String,
      riskLevel: json['riskLevel'] as String,
    );
  }

  // Convert object back to JSON
  Map<String, dynamic> toJson() {
    return {
      'DBP_ROT': dbpRot,
      'DBP_Supine': dbpSupine,
      'HR': hr,
      'MAP_ROT': mapRot,
      'MAP_Supine': mapSupine,
      'SBP_ROT': sbpRot,
      'SBP_Supine': sbpSupine,
      'mapStatus': mapStatus,
      'riskLevel': riskLevel,
    };
  }
}
