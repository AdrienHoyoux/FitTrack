import 'package:flutter/material.dart';
import 'package:myappflutter/screens/home_screen.dart';

void main() {
  runApp(myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FitTrack',
      theme: ThemeData(
        primaryColor: Colors.grey[600],
        hintColor: Color(0xFFFEF9EB),
      ),
      home: HomeScreen(),
      );
  }
}