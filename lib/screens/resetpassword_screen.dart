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
        appBar: AppBar(
          title: Text('Réinitialisation du mot de passe'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0), // Ajout d'un padding global
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Alignement à gauche pour éviter que le texte ne dépasse
              children: <Widget>[
                SizedBox(height: 200),
                Text(
                  'Saisissez l\'adresse électronique de votre compte :',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: 320,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Email...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 320,
                  child: Text(
                    'Un lien de réinitialisation du mot de passe vous sera envoyé par courrier électronique.',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: 320,
                    child: ElevatedButton(
                      onPressed: (){},
                      child: Text('Confirmer'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black12,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            width: 2,
                            color: Colors.grey,
                          ),
                        ),
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
