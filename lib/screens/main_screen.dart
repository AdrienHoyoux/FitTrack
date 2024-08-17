import 'package:flutter/material.dart';
import 'package:FitTrack/screens/performance_screen.dart';
import 'package:FitTrack/screens/profile_screen.dart';
import 'package:FitTrack/screens/settings_screen.dart';
import 'home_screen.dart';
import 'map_screen.dart';

class MainScreen extends StatefulWidget {
  static String routeName = '/main';

  final int initialIndex;

  MainScreen({Key? key, this.initialIndex = 0}) : super(key: key); // Ajout du paramètre initialIndex

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final tabs = [
    HomeScreen(),
    MapScreen(),
    PerformanceScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex; // Initialiser avec le paramètre initialIndex
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black45,
        automaticallyImplyLeading: false,
        title: Text(
          'FitTrack',
          style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle, size: 35.0, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, ProfileScreen.routeName);
            },
          ),
          IconButton(
            icon: Icon(Icons.settings, size: 35.0, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, SettingsScreen.routeName);
            },
          ),
        ],
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
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
