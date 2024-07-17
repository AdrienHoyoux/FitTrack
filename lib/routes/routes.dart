import 'package:flutter/material.dart';
import 'package:myappflutter/screens/main_screen.dart';
import 'package:myappflutter/screens/map_screen.dart';
import 'package:myappflutter/screens/performance_screen.dart';
import 'package:myappflutter/screens/profile_screen.dart';
import 'package:myappflutter/screens/register_screen.dart';
import 'package:myappflutter/screens/resetpassword_screen.dart';
import 'package:myappflutter/screens/settings_screen.dart';
import 'package:myappflutter/screens/home_screen.dart';
import 'package:myappflutter/screens/connexion_screen.dart';
import 'package:myappflutter/screens/userinfo_screen.dart';

var routes = <String, WidgetBuilder>{
  HomeScreen.routeName: (context) => HomeScreen(),
  MapScreen.routeName: (context) => MapScreen(),
  PerformanceScreen.routeName: (context) => PerformanceScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  SettingsScreen.routeName: (context) => SettingsScreen(),
  ResetPasswordScreen.routeName: (context) => ResetPasswordScreen(),
  RegisterScreen.routeName: (context) => RegisterScreen(),
  ConnexionScreen.routeName: (context) => ConnexionScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  MainScreen.routeName: (context) => MainScreen(),
  UserInfoComponent.routeName: (context) => UserInfoComponent(),
};
