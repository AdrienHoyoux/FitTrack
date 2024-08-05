import 'package:flutter/material.dart';
import 'package:myappflutter/widgets/field/emailField.dart';
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

  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DatabaseService _databaseService = DatabaseService();


  @override
  void dispose() {
    mailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _registerUser() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Votre compte est en cours de création...'),
        ),
      );

      bool userCreated = await _databaseService.registerUser(
        mailController.text,
        passwordController.text,
      );

      if (userCreated) {
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
            content: Text('Échec de la création de compte'),
            duration: Duration(seconds: 10),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
