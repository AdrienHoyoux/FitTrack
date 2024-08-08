class Race {
  String? name;
  final String date;
  final String time;
  final double distance;
  final double speed;
  final double calories;

  Race({
    this.name,
    required this.date,
    required this.time,
    required this.distance,
    required this.speed,
    required this.calories,
  });

  factory Race.fromJson(Map<String, dynamic> json) {
    return Race(
      name: json['name'],
      date: json['date'],
      time: json['time'],
      distance: json['distance'],
      speed: json['speed'],
      calories: json['calories'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'date': date,
      'time': time,
      'distance': distance,
      'speed': speed,
      'calories': calories,
    };
  }
}