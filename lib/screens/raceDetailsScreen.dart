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
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Icon(Icons.directions_run),
                  title: Text(
                    'Nom',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(race.name ?? 'Non défini'),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.calendar_today),
                  title: Text(
                    'Date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(race.date),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.access_time),
                  title: Text(
                    'Durée de la course',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(race.time),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.straighten),
                  title: Text(
                    'Distance',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('${race.distance} km'),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.speed),
                  title: Text(
                    'Vitesse',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('${race.speed} km/h'),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.local_fire_department),
                  title: Text(
                    'Calories dépensées',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('${race.calories} kcal'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
