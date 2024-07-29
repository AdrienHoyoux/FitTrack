import 'package:flutter/material.dart';
import 'package:myappflutter/classes/race.dart';

class RaceDetailScreen extends StatelessWidget {
  final Race race;

  RaceDetailScreen({required this.race});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de la course'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nom: ${race.name ?? 'Non défini'}',
            ),
            SizedBox(height: 10),
            Text(
              'Date: ${race.date}',
            ),
            SizedBox(height: 10),
            Text(
              'Heure: ${race.time}',
            ),
            SizedBox(height: 10),
            Text(
              'Distance: ${race.distance} km',
            ),
            SizedBox(height: 10),
            Text(
              'Vitesse: ${race.speed} km/h',
            ),
            SizedBox(height: 10),
            Text(
              'Calories: ${race.calories} kcal',
            ),
          ],
        ),
      ),
    );
  }
}
