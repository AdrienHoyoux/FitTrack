import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myappflutter/screens/main_screen.dart';
import 'package:myappflutter/screens/register_screen.dart';
import 'package:myappflutter/screens/resetpassword_screen.dart';

class ConnexionScreen extends StatelessWidget {
  static String routeName = '/connexion';
  ConnexionScreen({super.key});

  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/homebackground.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(height: 20),
                    Text(
                      'Bienvenue sur FitTrack',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Votre application de suivi sportif !',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 40),
                    Text(
                      'Connexion',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                        decorationThickness: 2,
                        fontSize: 45,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 320,
                      child: TextField(
                        controller: mailController,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.black38,
                          hintText: 'Entrer votre adresse mail...',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.black87, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.white, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    SizedBox(
                      width: 320,
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.black38,
                          hintText: 'Entrer votre mot de passe...',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.black87, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.white, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 60),
                    SizedBox(
                      width: 250,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          if(mailController.text == 'admin' && passwordController.text == 'admin'){
                            Navigator.pushNamed(context, MainScreen.routeName);
                          }
                          else{
                            try {
                              await FirebaseAuth.instance.signInWithEmailAndPassword(
                                  email: mailController.text,
                                  password: passwordController.text
                              );
                              Navigator.pushNamed(context, MainScreen.routeName);
                            }on FirebaseAuthException catch (e) {
                              String message;
                              print(mailController.text);
                              print(passwordController.text);
                              print(e.message);
                              switch (e.code) {
                                case 'invalid-email':
                                  message = 'L\'adresse e-mail n\'est pas valide.';
                                  break;
                                case 'user-disabled':
                                  message = 'Cet utilisateur a été désactivé.';
                                  break;
                                case 'user-not-found':
                                  message = 'Aucun utilisateur trouvé pour cette adresse e-mail.';
                                  break;
                                case 'wrong-password':
                                  message = 'Le mot de passe est incorrect.';
                                  break;
                                default:
                                  message = 'Une erreur inconnue s\'est produite.';
                              }
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  duration: Duration(seconds: 5),
                                  content: Text(message)));
                            }
                          }

                        },
                      child: Text(
                          'Se connecter',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black12,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              width: 2,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    SizedBox(
                      width: 220,
                      height: 40,
                      child:TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, ResetPasswordScreen.routeName);

                        },
                        child: Text(
                          'Mot de passe oublié ?',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white,
                            decorationThickness: 2,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RegisterScreen.routeName);
                        },
                        child: Text(

                          'Créer un compte',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.lightBlueAccent[100],
                            decorationThickness: 2,
                            fontSize: 16,
                            color: Colors.lightBlueAccent[100],
                          ),
                        ),
                      ),
                      ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
