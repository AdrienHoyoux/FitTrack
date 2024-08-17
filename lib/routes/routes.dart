import 'package:flutter/material.dart';
import 'package:FitTrack/classes/race.dart';
import 'package:FitTrack/screens/main_screen.dart';
import 'package:FitTrack/screens/map_screen.dart';
import 'package:FitTrack/screens/performance_screen.dart';
import 'package:FitTrack/screens/profile_screen.dart';
import 'package:FitTrack/screens/register_screen.dart';
import 'package:FitTrack/screens/resetpassword_screen.dart';
import 'package:FitTrack/screens/saverace_screen.dart';
import 'package:FitTrack/screens/settings_screen.dart';
import 'package:FitTrack/screens/home_screen.dart';
import 'package:FitTrack/screens/connexion_screen.dart';
import 'package:FitTrack/screens/userinfo_screen.dart';

var routes = <String, WidgetBuilder>{
  HomeScreen.routeName: (context) =>  HomeScreen(),
  MapScreen.routeName: (context) =>  MapScreen(),
  PerformanceScreen.routeName: (context) =>  PerformanceScreen(),
  ProfileScreen.routeName: (context) =>  ProfileScreen(),
  SettingsScreen.routeName: (context) =>  SettingsScreen(),
  ResetPasswordScreen.routeName: (context) =>  ResetPasswordScreen(),
  RegisterScreen.routeName: (context) =>  RegisterScreen(),
  ConnexionScreen.routeName: (context) =>  ConnexionScreen(),
  MainScreen.routeName: (context) =>  MainScreen(),
  UserInfoComponent.routeName: (context) =>  UserInfoComponent(),
  SaveRaceScreen.routeName: (context) {
    final Race course = ModalRoute.of(context)!.settings.arguments as Race;
    return SaveRaceScreen(course: course);
  },};
