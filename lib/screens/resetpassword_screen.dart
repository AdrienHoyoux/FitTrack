import 'package:flutter/material.dart';
import 'package:FitTrack/widgets/buttons/action%20_button.dart';
import 'package:FitTrack/widgets/field/emailField.dart';
import '../classes/firebase_exception.dart';
import '../services/database_service.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String routeName = '/resetpassword';
   ResetPasswordScreen({super.key});
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}
class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  /***************************************** Variables ************************************** */
  final TextEditingController _emailController = TextEditingController();
  bool waiting = false;
  final DatabaseService _dataBaseService = DatabaseService();
  final _formKey = GlobalKey<FormState>();
  static late AuthStatus _status;
  static const int time_snackbar = 3;

  /***************************************** Methodes ************************************** */
  void confirmButton() async {

    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AuthExceptionHandler.generateErrorMessage(AuthStatus.invalidEmail)),
          duration: Duration(seconds: time_snackbar),
        ),
      );
      return;
    }

    setState(() {
      waiting = true;
    });

    final String email = _emailController.text;
    _status = await _dataBaseService.resetPassword(email);

    if (_status == AuthStatus.successful) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Nous vous avons envoyé un mail pour réinitialiser votre mot de passe à l'adresse : $email",),
          duration: Duration(seconds: time_snackbar),
        ),
      );
    }

    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AuthExceptionHandler.generateErrorMessage(_status)),
          duration: Duration(seconds: time_snackbar),
        ),
      );
    }

    setState(() {
      waiting = false;
    });
  }

  @override
  void dispose(){
    _emailController.dispose();
    super.dispose();
  }


  /***************************************** Widgets ************************************** */
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
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Form(
                  key: _formKey,
                  child: Center(
                    child: EmailField(controller: _emailController,showLabel: true,showTooltip: true,)
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
                    child: ActionButton(
                      text: 'Envoyer',
                      onPressed: confirmButton,
                    )
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: CircularProgressIndicator(
                    value: waiting ? null : 0,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
