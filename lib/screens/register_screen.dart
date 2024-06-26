import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  bool _userCreated = false;
  final TextEditingController  mailController = TextEditingController();
  final TextEditingController  passwordController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0), // Ajout d'un padding global
          child: Form(
            child:Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Alignement à gauche pour éviter que le texte ne dépasse
                children: <Widget>[
                  Text('Register now for free !',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 150),
                  Text(
                    'Email',
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
                          labelText: 'Enter an email address',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Password:',
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
                          labelText: 'Create password',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 120),
                  Center(
                    child: SizedBox(
                      width: 320,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          try{
                            await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                email: mailController.text,
                                password: passwordController.text).then((value){
                              setState(() {
                                _userCreated = true;
                              });
                            });

                            if(_userCreated){
                              Navigator.pop(context);
                            }
                          } on FirebaseAuthException catch (e){
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
                                backgroundColor: Colors.red, // Changez cette couleur selon vos besoins
                              ),
                            );
                          }
                        }
                        ,
                        child: Text('Register',
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.redAccent,
                        ),
                      ),
                    ),
                  ),
                ]
            ),
          )
      ),
      ),
    );
  }
}