import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0), // Ajout d'un padding global
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Alignement à gauche pour éviter que le texte ne dépasse
            children: <Widget>[
              Text('Register now for free !',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 50),
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
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'enter an email address',
                      border: OutlineInputBorder(),
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
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Create password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Confirm password:',
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
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Retype password ',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
              Center(
                child: SizedBox(
                  width: 320,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: (){},
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
      ),
      ),
    );
  }
}