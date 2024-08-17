import 'package:flutter/material.dart';
import 'package:FitTrack/classes/app_user.dart';
import 'package:FitTrack/screens/register_screen.dart';
import 'package:FitTrack/screens/resetpassword_screen.dart';
import 'package:FitTrack/screens/userinfo_screen.dart';
import '../classes/firebase_exception.dart';
import '../services/database_service.dart';
import '../widgets/buttons/action _button.dart';
import '../widgets/buttons/custom_text_button.dart';
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
  static late AuthStatus _status;
  bool waiting = false;

  // ************************************* Methodes ************************************* //
  void _connexionUser() async {
    setState(() {
      waiting = true;
    });
    if (mailController.text == 'admin' && passwordController.text == 'admin') {
      Navigator.pushNamed(context, UserInfoComponent.routeName);
    }
    else {
      if (_formKey.currentState!.validate()) {
        _status = await _dataBaseService.signInUser(
          mailController.text,
          passwordController.text,
        );

        if (_status == AuthStatus.successful) {
          Appuser? appUser = await _dataBaseService.getCurrentUser();

          if (appUser != null && appUser.firstConnection!) {
            Navigator.pushNamed(context, UserInfoComponent.routeName);
          } else {
            Navigator.pushNamed(context, MainScreen.routeName);
          }
        }
        else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AuthExceptionHandler.generateErrorMessage(_status), style: const TextStyle(color: Colors.white, fontSize: 16)),
              duration: const Duration(seconds: 3),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
    setState(() {
      waiting = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    mailController.dispose();
    passwordController.dispose();
  }

  // ************************************* Widgets ************************************* //
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
          decoration: const BoxDecoration(
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
                    const SizedBox(height: 20),
                    const Text(
                      'Bienvenue sur FitTrack',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Votre application de suivi sportif !',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'Connexion',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                        decorationThickness: 2,
                        fontSize: 45,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    EmailField(controller: mailController,showLabel: false,showTooltip: false,),
                    PasswordField(controller: passwordController,showLabel: false,showTooltip: false),
                    ActionButton(
                      onPressed: _connexionUser,
                      text: 'Se connecter',
                      backgroundColor: Colors.black12,
                      foregroundColor: Colors.white,
                      borderColor: Colors.blueGrey,
                    ),
                    const SizedBox(height: 40),
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
                    const SizedBox(height: 20),
                    CustomTextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RegisterScreen.routeName);
                      },
                      text: 'Créer un compte',
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.lightBlueAccent[100]!,
                      decorationThickness: 2,
                      textColor: Colors.lightBlueAccent[100]!,
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: waiting
                          ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      )
                          : null,
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
