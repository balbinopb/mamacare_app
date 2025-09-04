

class RiskCardModel {
  final String title;
  final String level;
  final List<double> heartbeatPattern;

  RiskCardModel({
    required this.title,
    required this.level,
    required this.heartbeatPattern,
  });
}