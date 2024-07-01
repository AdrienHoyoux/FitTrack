import 'package:flutter/material.dart';
import 'package:myappflutter/screens/connexion_screen.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'firebase_options.dart';
import 'routes/routes.dart';

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
      home: ConnexionScreen(),
      initialRoute: ConnexionScreen.routeName,
      routes: routes,
    );
  }
}