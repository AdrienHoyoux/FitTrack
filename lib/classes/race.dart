
class Race {
  String? _name;
  final String date;
  final String time;
  final double distance;
  final double speed;
  final double calories;

  Race({
    required String? name,
    required this.date,
    required this.time,
    required this.distance,
    required this.speed,
    required this.calories
  }) : _name = name;

  String? get name => _name;
  set name(String? value) {
    _name = value;
  }

  factory Race.fromJson(Map<String, dynamic> json) {
    return Race(
        name: json['name'],
        date: json['date'],
        time: json['time'],
        distance: json['distance'],
        speed: json['speed'],
        calories: json['calories']
    );
  }

  Map<String, Object?> toJson() {
    return {
      'name': _name,
      'date': date,
      'time': time,
      'distance': distance,
      'speed': speed,
      'calories': calories
    };
  }
}
