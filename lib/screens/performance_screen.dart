import 'package:flutter/material.dart';
import 'package:myappflutter/classes/race.dart';
import 'package:myappflutter/screens/map_screen.dart';
import 'package:myappflutter/screens/raceDetailsScreen.dart';
import 'package:myappflutter/services/database_service.dart';

class PerformanceScreen extends StatefulWidget {
  static const String routeName = '/performance';
  PerformanceScreen({super.key});

  @override
  _PerformanceScreenState createState() => _PerformanceScreenState();
}

class _PerformanceScreenState extends State<PerformanceScreen> {
  final DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Race>>(
        future: _databaseService.getRaces(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erreur: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Vous n\'aviez pas encore de course enregistrée.'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, MapScreen.routeName);
                    },
                    child: Text('Démarrer une course !'),
                  ),
                ],
              ),
            );
          } else {
            final races = snapshot.data!;
            return ListView.builder(
              itemCount: races.length,
              itemBuilder: (context, index) {
                final race = races[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ListTile(
                    title: Text(race.name ?? 'Nom inconnu'),
                    leading: Icon(Icons.directions_run),
                    subtitle: Text(race.date),
                    trailing: Text('${race.distance} km'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RaceDetailScreen(race: race),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
