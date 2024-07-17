import 'package:flutter/material.dart';
import 'package:myappflutter/screens/performance_screen.dart';
import 'package:myappflutter/screens/profile_screen.dart';
import 'package:myappflutter/screens/settings_screen.dart';
import '../services/database_service.dart';
import 'home_screen.dart';
import 'map_screen.dart';

class MainScreen extends StatefulWidget {
  static String routeName = '/main';
  MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int value = 0;
  int _currentIndex = 0;

  final tabs = [
    HomeScreen(),
    MapScreen(),
    PerformanceScreen(),
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar : AppBar(
        backgroundColor: Colors.black45,
        automaticallyImplyLeading: false,
        title: Text('FitTrack',style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,color: Colors.white),),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle,size: 35.0,color: Colors.white),
            onPressed: (){
             Navigator.pushNamed(context, ProfileScreen.routeName);
            },
          ),
          IconButton(
            icon: Icon(Icons.settings,size: 35.0,color: Colors.white),
            onPressed: (){
              Navigator.pushNamed(context, SettingsScreen.routeName);
            },
          ),
        ],
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Carte',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_score),
            label: 'Performances',
          ),

        ],
      ),
    );
  }
}