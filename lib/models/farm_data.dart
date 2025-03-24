class FarmData {
  final String name;
  final String type;
  final String cropType;
  final int area;
  final DateTime plantingDate;
  final double temperature;
  final double soilPH;
  final int soilMoisture;
  final int soilNitrogen;
  final DateTime lastUpdated;

  FarmData({
    required this.name,
    required this.type,
    required this.cropType,
    required this.area,
    required this.plantingDate,
    required this.temperature,
    required this.soilPH,
    required this.soilMoisture,
    required this.soilNitrogen,
    required this.lastUpdated,
  });
}