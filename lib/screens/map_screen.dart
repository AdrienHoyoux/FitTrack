import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myappflutter/screens/saverace_screen.dart';
import 'package:myappflutter/widgets/courseStat_component.dart';
import 'package:myappflutter/widgets/map_component.dart';
import 'package:provider/provider.dart';

import '../classes/race.dart';
import '../notifier/courseStateNotifier.dart';

class MapScreen extends StatefulWidget {
  static const String routeName = '/map';
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  void _toggleRecording(courseStateNotifier notifier) {
    notifier.isRecording = true;
  }

  void _stopRecording(courseStateNotifier notifier) {
    notifier.isPaused = true;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Voulez-vous terminer la course ?'),
          actions: [
            Center(
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      notifier.isPaused = false;
                    },
                    child: Text('Reprendre', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                  TextButton(
                    onPressed: () {
                      notifier.isRecording = false;
                      Race course = Race(
                        name: 'Votre course...',
                        distance: notifier.distance,
                        speed: notifier.speed,
                        calories: double.parse(notifier.calories.toStringAsFixed(2)),
                        date: DateFormat('dd/MM/yyyy').format(DateTime.now()),
                        time: formatDuration(notifier.lastDuration),
                      );
                      Navigator.pop(context);
                      Navigator.pushNamed(
                        context,
                        SaveRaceScreen.routeName,
                        arguments: course,
                      );
                      notifier.isReset = true;
                    },
                    child: Text('Enregistrer', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                  TextButton(
                      onPressed: () {
                        print("Annuler");
                        notifier.isPaused = false;
                        notifier.isRecording = false;
                        notifier.isReset = true;
                        Navigator.pop(context);
                      },
                      child: Text('Annuler', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),

          ],
        );
      },
    );
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => courseStateNotifier(false, false),
      child: Scaffold(
        body: Consumer<courseStateNotifier>(
          builder: (context, notifier, child) {
            return Column(
              children: [
                CourseStat(),
                Expanded(
                  child: Stack(
                    children: [
                      MapComponent(),
                      if (!notifier.isRecording)
                        Align(
                          alignment: Alignment.center,
                          child: FloatingActionButton(
                            onPressed: () => _toggleRecording(notifier),
                            child: Icon(Icons.fiber_manual_record, color: Colors.red),
                            backgroundColor: Colors.white,
                          ),
                        ),
                      if (notifier.isRecording)
                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: ElevatedButton(
                            onPressed: () => _stopRecording(notifier),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            child: Text(
                              'Arrêter',
                              style: TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
