import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../services/stravaAPI_service.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  HomeScreen({super.key});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // **************************** VARIABLES **************************** //
  bool _liked = false;
  Future<List<dynamic>>? _activitiesFuture;

  // **************************** METHODES **************************** //
  @override
  void initState() {
    super.initState();
    final stravaApiService = StravaApiService(accessToken: 'f1acc9072cbe41ac60262a1e7c8c2492734ffb85');
    _activitiesFuture = stravaApiService.getActivities();
  }

  // **************************** WIDGETS **************************** //
  DatabaseService dataBaseService = DatabaseService();

  // **************************** WIDGETS **************************** //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: _activitiesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No activities found'));
          }

          final activities = snapshot.data!;
          return ListView.builder(
            itemCount: activities.length,
            itemBuilder: (context, index) {
              final activity = activities[index];
              return Card(
                margin: EdgeInsets.all(10.0),
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Activité ${activity['name']}',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(activity['description'] ?? 'No description'),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Durée: ${(activity['moving_time'] / 60).round()} min'),
                          Text('Distance: ${(activity['distance'] / 1000).toStringAsFixed(2)} km'),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(Icons.thumb_up),
                            color: _liked ? Colors.blue : Colors.black,
                            onPressed: () {
                              setState(() {
                                _liked = !_liked;
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.comment),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
