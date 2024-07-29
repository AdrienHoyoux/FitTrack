import 'package:flutter/material.dart';
import '../services/database_service.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  HomeScreen({super.key});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // **************************** VARIABLES **************************** //
  bool _liked = false;
  // **************************** METHODES **************************** //

  // **************************** WIDGETS **************************** //
  DatabaseService dataBaseService = DatabaseService();

  // **************************** WIDGETS **************************** //
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
      return Card(
        margin: EdgeInsets.all(10.0),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Activité ${index+1}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text('Description de l\'activité ${index+1}'),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Durée: 30 min'),
                  Text('Distance: 5 km'),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(icon: Icon(Icons.thumb_up), color: _liked == true ? Colors.blue : Colors.black , onPressed: () {
                    setState(() {
                      _liked = !_liked;
                    });
                  }),
                  IconButton(icon: Icon(Icons.comment), onPressed: () {

                  }),
                ],
              ),
            ],
          ),
        ),
      );
    },
    );
  }
}
