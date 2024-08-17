import 'package:flutter/material.dart';
import 'package:FitTrack/classes/race.dart';
import 'package:FitTrack/screens/main_screen.dart';
import 'package:FitTrack/widgets/button/action%20_button.dart';
import 'package:FitTrack/widgets/component/dialog_component.dart';

import '../services/database_service.dart';

class RaceDetailScreen extends StatelessWidget {
  final Race race;
  final String raceId;
  final DatabaseService _databaseService = DatabaseService();

  RaceDetailScreen({required this.race,required this.raceId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de la course'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
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
              SizedBox(height: 35),
              Center(
                child: ActionButton(
                  fontSize: 20,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DialogComponent(
                          onPressed: () async {
                            await _databaseService.deleteRace(raceId);
                          },
                          content: 'Êtes-vous sûr de vouloir supprimer cette course ?',
                          title: 'Supprimer une course',
                          text1: 'Annuler',
                          text2: 'Ok',
                          routeName: MainScreen.routeName,
                          screenIndex: 2,
                        );
                      },
                    );
                  },
                  backgroundColor:Colors.pinkAccent,
                  borderColor: Colors.black,
                  width: 350,
                  text: "Supprimer la course",
                ),
              ),
            ],
          ),

        ),
      ),
    );
  }
}
