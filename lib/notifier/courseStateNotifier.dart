import 'package:flutter/material.dart';
import 'dart:async';

class courseStateNotifier extends ChangeNotifier {
  // ******************************** CONSTRUCTEUR ******************************** //
  courseStateNotifier(this._isRecording, this._isPaused);

  // ******************************** VARIABLES ******************************** //
  bool _isRecording = false;
  bool _isPaused = false;
  Duration _duration = Duration();
  double _distance = 0.0;
  double _speed = 0.0;
  double _calories = 0.0;
  Timer? _timer;
  Duration _lastDuration = Duration();
  bool _isReset = false;

  // ******************************** GETTERS ******************************** //

  bool get isReset => _isReset;
  bool get isRecording => _isRecording;
  bool get isPaused => _isPaused;
  Duration get duration => _duration;
  double get distance => double.parse(_distance.toStringAsFixed(2));
  double get speed => _speed;
  double get calories => double.parse(_calories.toStringAsFixed(2));
  Duration get lastDuration => _lastDuration;

  // ******************************** SETTERS ******************************** //

  set isReset(bool value) {
    _isReset = value;

    if(_isReset) {
      _distance = 0.0;
      _speed = 0.0;
      _calories = 0.0;
      _lastDuration = Duration();
    }
    notifyListeners();
  }

  set isRecording(bool value) {
    _isRecording = value;
    if (_isRecording) {
      _startTimer();
    } else {
      _stopTimer();
    }
    notifyListeners();
  }

  set isPaused(bool value) {
    _isPaused = value;
    if (_isPaused) {
      _pauseTimer();
    } else {
      _resumeTimer();
    }
    notifyListeners();
  }

  set distance(double value) {
    _distance = value;
    notifyListeners();
  }

  set speed(double value) {
    _speed = value;
    notifyListeners();
  }

  set calories(double value) {
    _calories = value;
    notifyListeners();
  }


  void _startTimer() {
    _duration = Duration();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _duration += Duration(seconds: 1);
      notifyListeners();
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
  }

  void _resumeTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _duration += Duration(seconds: 1);
      notifyListeners();
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _lastDuration = _duration;
    _duration = Duration();
  }

  void dispose() {
    _stopTimer();
    super.dispose();
  }
}

