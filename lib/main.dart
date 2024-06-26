import 'package:flutter/material.dart';
import 'package:myappflutter/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const myApp());
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