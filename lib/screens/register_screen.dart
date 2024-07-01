import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = '/register';
  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController mailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    void _registerUser() async {
      bool userCreated = false;
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: mailController.text,
          password: passwordController.text,
        ).then((value) {
          userCreated = true;
        });

        if (userCreated) {
          Navigator.pop(context);
        }
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(e.message!)),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                ),
              ],
            ),
            duration: Duration(seconds: 10),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0), // Ajout d'un padding global
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Alignement à gauche pour éviter que le texte ne dépasse
              children: <Widget>[
                Text(
                  'Créer un compte gratuitement',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 50),
                Text(
                  'Adresse e-mail:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: 320,
                    height: 50,
                    child: TextFormField(
                      controller: mailController,
                      decoration: InputDecoration(
                        labelText: 'Entrer votre adresse e-mail...',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Mot de passe:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: 320,
                    height: 50,
                    child: TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Créez un mot de passe...',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 60),
                Center(
                  child: SizedBox(
                    width: 320,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _registerUser,
                      child: Text(
                        'S\'inscrire',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black45,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
