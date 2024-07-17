class Race {

  final String date;
  final String time;
  final double distance;
  final double speed;
  final double calories;

  const Race({
    required this.date,
    required this.time,
    required this.distance,
    required this.speed,
    required this.calories
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'time': time,
      'distance': distance,
      'speed': speed,
      'calories': calories
    };
  }

}