import 'package:flutter/material.dart';
import 'package:FitTrack/screens/connexion_screen.dart';
import 'package:FitTrack/services/database_service.dart';
import 'package:FitTrack/widgets/component/setting_card_component.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = '/settings';
   SettingsScreen({super.key});
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  // ***************************************** DatabaseService ***************************************** //
  DatabaseService _databaseService = DatabaseService();

  // ***************************************** Methodes  ***************************************** //
  void _showLogoutDialog() {
    _showDialog(
      context,
      'Déconnexion',
      'Voulez-vous vraiment vous déconnecter ?',
      'Annuler',
      'Déconnexion',
      ConnexionScreen.routeName,
    );
  }

  void _showDeleteAccountDialog() {
    _showDialog(
      context,
      'Suppression du compte',
      'Voulez-vous vraiment supprimer votre compte ?',
      'Annuler',
      'Supprimer',
      ConnexionScreen.routeName,
    );
  }

  Future<void> _showDialog(BuildContext context,
      String title,
      String content,
      String action1,
      String action2,
      String routeName,) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(action1),
            ),
            TextButton(
              onPressed: () {
                if (title == 'Suppression du compte') {
                  _databaseService.deleteUser();
                } else if (title == 'Déconnexion') {
                  _databaseService.signOut();
                }
                Navigator.pushNamed(context, routeName);
              },
              child: Text(action2),
            ),
          ],
        );
      },
    );
  }


  // ***************************************** Widgets ***************************************** //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Paramètres',
          style: TextStyle(
              fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            SettingsCard(icon: Icons.delete_forever,
                title: 'Supprimer le compte',
                color: Colors.red,
                onPressed: _showDeleteAccountDialog),
            SizedBox(height: 20.0),
            SettingsCard(icon: Icons.logout,
                title: 'Déconnexion',
                color: Colors.blue,
                onPressed: _showLogoutDialog),
          ],
        ),
      ),
    );
  }
}
