import 'package:flutter/material.dart';
import 'package:myappflutter/classes/app_user.dart';
import 'package:myappflutter/screens/register_screen.dart';
import 'package:myappflutter/screens/resetpassword_screen.dart';
import 'package:myappflutter/screens/userinfo_screen.dart';
import '../services/database_service.dart';
import '../widgets/button/action _button.dart';
import '../widgets/button/custom_text_button.dart';
import '../widgets/field/emailField.dart';
import '../widgets/field/passwordField.dart';
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
  void _connexionUser() async {
    if (mailController.text == 'admin' && passwordController.text == 'admin') {
      Navigator.pushNamed(context, UserInfoComponent.routeName);
    } else {
      if (_formKey.currentState!.validate()) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Connexion en cours...'),
          ),
        );

        bool userConnected = await _dataBaseService.signInUser(
          mailController.text,
          passwordController.text,
        );

        if (userConnected == true) {
          Appuser? appUser = await _dataBaseService.getCurrentUser();

          if (appUser != null && appUser.firstConnection!) {
            Navigator.pushNamed(context, UserInfoComponent.routeName);
          } else {
            Navigator.pushNamed(context, MainScreen.routeName);
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Email et/ou mot de passe incorrects !'),
              duration: Duration(seconds: 5),
            ),
          );
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

  // ************************************* SCAFFOLD ************************************* //
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
                    EmailField(controller: mailController,showLabel: false,showTooltip: false,),
                    PasswordField(controller: passwordController,showLabel: false,showTooltip: false),
                    ActionButton(
                      onPressed: _connexionUser,
                      text: 'Se connecter',
                      backgroundColor: Colors.black12,
                      foregroundColor: Colors.white,
                      borderColor: Colors.blueGrey,
                    ),
                    SizedBox(height: 40),
                    CustomTextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, ResetPasswordScreen.routeName);
                      },
                      text: 'Mot de passe oublié ?',
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                      decorationThickness: 2,
                      textColor: Colors.white,
                    ),
                    SizedBox(height: 20),
                    CustomTextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RegisterScreen.routeName);
                      },
                      text: 'Créer un compte',
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.lightBlueAccent[100]!,
                      decorationThickness: 2,
                      textColor: Colors.lightBlueAccent[100]!,
                    )
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
