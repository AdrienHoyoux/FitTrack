import 'package:flutter/material.dart';
import 'package:myappflutter/screens/connexion_screen.dart';
import 'package:myappflutter/services/database_service.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = '/settings';
  SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Paramètres',
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
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
            buildSettingsCard(Icons.delete_forever, 'Supprimer le compte', Colors.red, _showDeleteAccountDialog),
            SizedBox(height: 20.0),
            buildSettingsCard(Icons.logout, 'Déconnexion', Colors.blue, _showLogoutDialog),
          ],
        ),
      ),
    );
  }

  Widget buildSettingsCard(IconData icon, String title, Color color, VoidCallback onPressed) {
    return Card(
      color: Colors.black54,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: color, size: 30),
        title: Text(
          title,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        onTap: onPressed,
      ),
    );
  }

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

  Future<void> _showDialog(
    BuildContext context,
    String title,
    String content,
    String action1,
    String action2,
    String routeName,
    )
    {
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
                  if(title == 'Suppression du compte') {
                    print('Suppression du compte');
                    _databaseService.deleteUser();
                  } else if(title == 'Déconnexion') {
                    print('Déconnexion');
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
}
