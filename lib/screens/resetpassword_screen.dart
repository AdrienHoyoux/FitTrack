import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {

  static const String routeName = '/resetpassword';
  ResetPasswordScreen({super.key});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: Text('Réinitialisation du mot de passe', style: TextStyle(fontSize: 21.0, color: Colors.white)),
          backgroundColor: Colors.black45,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0), // Ajout d'un padding global
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Alignement à gauche pour éviter que le texte ne dépasse
              children: <Widget>[
                SizedBox(height: 60),
                Text(
                  'Saisissez l\'adresse électronique de votre compte :',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: 320,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Email...',
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                    textAlign: TextAlign.center,
                    'Un lien de réinitialisation du mot de passe vous sera envoyé par courrier électronique.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                ),
                SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: 320,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: (){},
                      child: Text('Confirmer', style: TextStyle(fontSize: 25)),
                      style: ElevatedButton.styleFrom(
                        elevation: 5.0,
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black45,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
