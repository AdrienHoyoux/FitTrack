import 'package:flutter/material.dart';
import 'package:myappflutter/notifier/courseStateNotifier.dart';
import 'package:provider/provider.dart';

class CourseStat extends StatefulWidget {
  @override
  State<CourseStat> createState() => _CourseStatState();
}

class _CourseStatState extends State<CourseStat> {
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _speedController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _distanceController.text = '0 km';
    _durationController.text = '00:00:00';
    _speedController.text = '0 km/h';
    _caloriesController.text = '0 kcal';
  }

  @override
  void dispose() {
    _distanceController.dispose();
    _durationController.dispose();
    _speedController.dispose();
    _caloriesController.dispose();
    super.dispose();
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    courseStateNotifier courseState = Provider.of<courseStateNotifier>(context);
    _durationController.text = formatDuration(courseState.duration);
    _speedController.text = '${courseState.speed.toStringAsFixed(2)} km/h';
    _caloriesController.text = '${courseState.calories.toStringAsFixed(2)} kcal';
    _distanceController.text = '${courseState.distance.toStringAsFixed(2)} km';
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                  readOnly: true,
                  controller: _speedController,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.speed),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  readOnly: true,
                  controller: _caloriesController,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.monitor_weight_outlined),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                  readOnly: true,
                  controller: _durationController,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.timer_outlined),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _distanceController,
                  readOnly: true,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.directions_walk_outlined),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
