import 'package:flutter/material.dart';
import 'package:myappflutter/screens/connexion_screen.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = '/settings';
  SettingsScreen({super.key});
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Paramètres',
          style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 10.0),
            buildSettingsCard('Autres', [
              buildSettingsButton(Icons.info, 'À propos'),
              buildSettingsButton(Icons.delete_forever, 'Supprimer le compte'),
              buildSettingsButton(Icons.logout, 'Déconnexion'),
            ]),
          ],
        ),
      ),
    );
  }

  Widget buildSettingsCard(String title, List<Widget> buttons) {
    return Card(
      color: Colors.black54,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white)),
            ...buttons,
          ],
        ),
      ),
    );
  }

  Widget buildSettingsButton(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextButton(
        onPressed: () {
          switch(title){
            case 'Déconnexion':
              _showDialog(context,'Déconnexion','Voulez-vous vraiment vous déconnecter ?','Annuler','Déconnexion');
              break;

            case 'Supprimer le compte':
              _showDialog(context,'Suppression du compte','Voulez-vous vraiment supprimer votre compte ?','Annuler','Supprimer');
              break;

          }
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(15.0),
          backgroundColor: Colors.white30,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 20.0),
            Text(title, style: TextStyle(fontSize: 16.0, color: Colors.white, fontStyle: FontStyle.italic)),
          ],
        ),
      ),
    );
  }
  Future<void> _showDialog(BuildContext context, String title, String content, String action1, String action2) {
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
                Navigator.pushNamed(context, ConnexionScreen.routeName);
              },
              child: Text(action2),
            ),
          ],
        );
      },
    );
  }
}
