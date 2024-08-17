import 'package:flutter/material.dart';
import 'package:FitTrack/widgets/field/emailField.dart';
import '../classes/firebase_exception.dart';
import '../services/database_service.dart';
import '../classes/app_user.dart';
import '../widgets/button/action _button.dart';
import '../widgets/field/passwordField.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register';
   RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  // ************************************* Variables ************************************* //
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  static late AuthStatus _status;
  bool waiting = false;

  // ************************************ Instances ************************************ //
  DatabaseService _databaseService = DatabaseService();

  // ************************************* Methodes ************************************* //
  @override
  void dispose() {
    mailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _registerUser() async {
    setState(() {
      waiting = true;
    });
    if (_formKey.currentState!.validate()) {
      _status = await _databaseService.registerUser(
        mailController.text,
        passwordController.text,
      );

      if (_status == AuthStatus.successful) {
        await _databaseService.addUser(Appuser(
          name: '',
          firstName: '',
          weight: '',
          biography: '',
          birthDate: '',
          firstConnection: true,
          imageURL: '',
        ));
        Navigator.pop(context);
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AuthExceptionHandler.generateErrorMessage(_status), style: TextStyle(color: Colors.white, fontSize: 16)),
            duration: Duration(seconds: 3),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
    setState(() {
      waiting = false;
    });
  }

  // ************************************* Widgets ************************************* //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.black45,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Créer un compte',style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,color: Colors.white),),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 50),
                EmailField(controller: mailController,showTooltip: true,showLabel: true,),
                PasswordField(controller: passwordController,showTooltip: true,showLabel: true,),
                Center(
                  child: ActionButton(
                    onPressed: _registerUser,
                    text: 'S\'inscrire',
                    backgroundColor: Colors.black45,
                    foregroundColor: Colors.white,
                    borderColor: Colors.transparent,
                    elevation: 5.0,
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: waiting
                      ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      )
                      : null,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
