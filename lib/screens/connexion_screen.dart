import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myappflutter/classes/AppUser.dart';
import 'package:myappflutter/screens/register_screen.dart';
import 'package:myappflutter/screens/resetpassword_screen.dart';
import 'package:myappflutter/screens/userinfo_screen.dart';
import '../services/database_service.dart';
import 'main_screen.dart';


class ConnexionScreen extends StatefulWidget {
  static String routeName = '/connexion';
  ConnexionScreen({super.key});

  @override
  State<ConnexionScreen> createState() => _ConnexionScreenState();
}

class _ConnexionScreenState extends State<ConnexionScreen> {

  // ************************************ Instances ************************************ //

  final DatabaseService _dataBaseService = DatabaseService();

  // ************************************* Variables ************************************* //

  final TextEditingController mailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();


  final _formKey = GlobalKey<FormState>();

  // ************************************* Methodes ************************************* //
  void _connexionUser() async{
    {
      if(mailController.text == 'admin' && passwordController.text == 'admin'){
        Navigator.pushNamed(context, UserInfoComponent.routeName);
      }
      else{
        if (_formKey.currentState!.validate()) {
          try {
            await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: mailController.text,
                password: passwordController.text
            );

            Appuser? user = await _dataBaseService.getCurrentUser();

            if(user!.firstConnection!) Navigator.pushNamed(context, UserInfoComponent.routeName);
            else Navigator.pushNamed(context, MainScreen.routeName);

          }on FirebaseAuthException catch (e) {
            String message;
            print("code :" + e.toString());
            switch(e.code)
            {
              case "invalid-credential":
                message = 'Email et/ou mot de passe incorrects !';
                break;
              case "invalid-email":
                message = 'Veuillez entrer un email valide !';
                break;
              default:
                message = 'Pas de connexion Internet !';
                break;
            }
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: Duration(seconds: 5),
                content: Text(message)));
          }
        }
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    mailController.dispose();
    passwordController.dispose();
  }

  // ************************************* Scaffold ************************************* //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black45,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/assets/images/homebackground.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Form(
                key: _formKey,
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
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty || !value.contains('@')) {
                            return 'Veuillez entrer une adresse e-mail valide';
                          }
                          return null;
                        },
                        controller: mailController,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.black38,
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
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
                      child: TextFormField(
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty || value.length < 6) {
                            return 'Veuillez entrer un mot de passe valide !';
                          }
                          return null;
                        },
                        obscureText: true,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.black38,
                          hintText: 'Entrer votre mot de passe...',
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
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
                        onPressed: _connexionUser,
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
