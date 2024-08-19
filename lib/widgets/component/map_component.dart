import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:FitTrack/services/database_service.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import '../../notifier/course_state_notifier.dart';

class MapComponent extends StatefulWidget {
  @override
  MapComponentState createState() => MapComponentState();
}

class MapComponentState extends State<MapComponent> {
  // ******************************** VARIABLES ******************************** //
  Position? _currentPosition;
  List<Position> _positions = [];
  Timer? _timer;
  double _totalDistance = 0.0;
  late double _userWeight;
  Duration _activeDuration = Duration.zero;
  late Future<double> _userWeightFuture;
  final DatabaseService _databaseService = DatabaseService();
  MapController _mapController = MapController();

  // ******************************** METHODES ******************************** //

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services sont désactivés.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions sont refusées');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions sont définitivement refusées, nous ne pouvons pas demander des permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  void addPosition(Position position) {
    if (_positions.isNotEmpty) {
      final lastPosition = _positions.last;
      final distance = Geolocator.distanceBetween(
        lastPosition.latitude,
        lastPosition.longitude,
        position.latitude,
        position.longitude,
      );
      _totalDistance += distance / 1000; // Convertir les mètres en kilomètres
    }
    _positions.add(position);
  }

  Position? getfirstPosition() {
    return _positions.isNotEmpty ? _positions.first : null;
  }

  Position? getlastPosition() {
    return _positions.length > 1 ? _positions.last : null;
  }

  void _startLocationUpdates(CourseStateNotifier courseState) {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _determinePosition().then((value) {
        setState(() {
          _currentPosition = value;
          addPosition(_currentPosition!);
          courseState.distance = _totalDistance;
          courseState.speed = _currentPosition!.speed * 3.6;

          if (courseState.isRecording && !courseState.isPaused) {
            _activeDuration += const Duration(seconds: 2);
          }
          calculCalorie(courseState);
          _mapController.move(LatLng(_currentPosition!.latitude, _currentPosition!.longitude),18.0);
        });
      }).catchError((e) {
        print(e);
      });
    });
  }

  void _handleCourseStateChange(CourseStateNotifier courseState) {
    if (courseState.isRecording && !courseState.isPaused) {
      if (_timer == null) {
        if (_positions.isEmpty && _currentPosition != null) {
          _positions.add(_currentPosition!);
        }
        _startLocationUpdates(courseState);
      }
    } else if (courseState.isPaused && _timer != null) {
      pauseTimer();
    } else if (!courseState.isRecording && _timer != null) {
      stopTimer();
    }

    if (courseState.isReset) {
      setState(() {
        _positions.clear();
        _totalDistance = 0.0;
        _activeDuration = Duration.zero;
      });
      courseState.isReset = false;
    }
  }

  void calculCalorie(CourseStateNotifier courseState) {
    double met;

    if (courseState.speed < 8) {
      met = 8.3;
    } else if (courseState.speed < 10) {
      met = 10;
    } else if (courseState.speed < 12) {
      met = 11.5;
    } else {
      met = 13.5;
    }

    double activeHours = _activeDuration.inSeconds / 3600.0;
    double caloriesBurned = met * _userWeight * activeHours;
    courseState.calories = caloriesBurned;
  }

  void pauseTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void stopTimer() {
    setState(() {
      _timer?.cancel();
      _timer = null;
    });
  }

  @override
  void initState() {
    super.initState();
    _userWeightFuture = _databaseService.getUserWeight();
    _determinePosition().then((value) {
      setState(() {
        _currentPosition = value;
        addPosition(_currentPosition!);
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final courseState = Provider.of<CourseStateNotifier>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleCourseStateChange(courseState);
    });

    return Scaffold(
      body: FutureBuilder<double>(
        future: _userWeightFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Poids non disponible'));
          } else {
            _userWeight = snapshot.data!;

            return _currentPosition == null
                ? const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: CircularProgressIndicator())
                : FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                center: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                zoom: 18.0,
                maxZoom: 18.0,
                minZoom: 12.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                if (getfirstPosition() != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: LatLng(getfirstPosition()!.latitude, getfirstPosition()!.longitude),
                        builder: (ctx) => Container(
                          child: const Icon(Icons.flag, color: Colors.green, size: 40.0),
                        ),
                      ),
                      if (getlastPosition() != null)
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: LatLng(getlastPosition()!.latitude, getlastPosition()!.longitude),
                          builder: (ctx) => Container(
                            child: const Icon(Icons.flag, color: Colors.red, size: 40.0),
                          ),
                        ),
                    ],
                  ),
                if (_positions.length > 1)
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: _positions.map((position) => LatLng(position.latitude, position.longitude)).toList(),
                        strokeWidth: 5.0,
                        color: Colors.blue,
                      ),
                    ],
                  ),
              ],
            );
          }
        },
      ),
    );
  }
}
