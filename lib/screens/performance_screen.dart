import 'package:flutter/material.dart';
import 'package:myappflutter/classes/race.dart';
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
      appBar: AppBar(
        title: Text('Performance'),
      ),
      body: FutureBuilder<List<Race>>(
        future: _databaseService.getRaces(), // Assurez-vous que cette méthode renvoie une Future<List<Race>>
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
              child: Text('Vous n\'aviez pas encore de course enregistrée.'),
            );
          } else {
            final races = snapshot.data!;
            return ListView.builder(
              itemCount: races.length,
              itemBuilder: (context, index) {
                final race = races[index];
                return ListTile(
                  title: Text(race.name ?? 'Nom inconnu'),
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
                );
              },
            );
          }
        },
      ),
    );
  }
}
