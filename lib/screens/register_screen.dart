import 'package:firebase_auth/firebase_auth.dart' as FA;
import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../classes/AppUser.dart';
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
    bool userCreated = false;

    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Votre compte est en cours de création...'),
        ),
      );
      try {
        await FA.FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: mailController.text,
          password: passwordController.text,
        )
            .then((value) {
          userCreated = true;
        });

        if (userCreated) {
          _databaseService.addUser(Appuser(name: '', firstName: '', weight: '', biography: '', birth_date: '', firstConnection: true, imageURL: ''));
          Navigator.pop(context);
        }
      } on FA.FirebaseAuthException catch (e) {
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
                Row(
                  children: [
                    Text(
                      'Adresse e-mail',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 10),
                    Tooltip(
                      message: 'Exemple d\'adresse e-mail: NameFirstname@example.com.',
                      child: Icon(Icons.help,size: 25.0,color: Colors.white,),
                      triggerMode: TooltipTriggerMode.tap,
                      showDuration: Duration(seconds: 10),
                      preferBelow: false,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(10.0),
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                      margin: EdgeInsets.only(left: 150,right: 20),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: 320,
                    height: 80,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty || !value.contains('@')) {
                          return 'Veuillez entrer une adresse e-mail valide';
                        }
                        return null;
                      },
                      controller: mailController,
                      decoration: InputDecoration(
                        hintText: 'Entrez votre adresse e-mail...',
                        prefixIcon: Icon(Icons.email),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Mot de passe',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 10),
                    Tooltip(
                      message: 'Le mot de passe doit contenir au moins 6 caractères dont une majuscule, une minuscule et un chiffre.',
                      child: Icon(Icons.help,size: 25.0,color: Colors.white,),
                      triggerMode: TooltipTriggerMode.tap,
                      showDuration: Duration(seconds: 10),
                      preferBelow: false,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(10.0),
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                      margin: EdgeInsets.only(left: 150,right: 20),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: 320,
                    height: 80,
                    child: TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty || value.length < 6 || !RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$').hasMatch(value)) {
                          return 'Veuillez entrer un mot de passe valide !';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Entrez votre mot de passe...',
                        prefixIcon: Icon(Icons.lock),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Center(
                  child: SizedBox(
                    width: 320,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _registerUser,
                      child: Text(
                        'S\'inscrire',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
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
        ),
      ),
    );
  }
}
