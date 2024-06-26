import 'package:flutter/material.dart';
import 'package:myappflutter/screens/register_screen.dart';
import 'package:myappflutter/screens/resetpassword_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                    SizedBox(height: 120),
                    Text(
                      'Welcome to FitTrack',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Track your fitness journey with us!',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 60),
                    Text(
                      'Log in',
                      style: TextStyle(
                        fontSize: 65,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 320,
                      child: TextField(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.black38,
                          hintText: 'username or email...',
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
                            borderRadius: BorderRadius.all(Radius.circular(10.0)), // Rounded corners
                            borderSide: BorderSide(color: Colors.black87, width: 2.0), // Border color when enabled
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)), // Rounded corners
                            borderSide: BorderSide(color: Colors.white, width: 2.0), // Border color when focused
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    SizedBox(
                      width: 320,
                      child: TextField(
                        obscureText: true,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.black38,
                          hintText: 'password...',
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
                            borderRadius: BorderRadius.all(Radius.circular(10.0)), // Rounded corners
                            borderSide: BorderSide(color: Colors.black87, width: 2.0), // Border color when enabled
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)), // Rounded corners
                            borderSide: BorderSide(color: Colors.white, width: 2.0), // Border color when focused
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 60),
                    SizedBox(
                      width: 220,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {},

                        child: Text(
                          'Log in',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black87,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              width: 2,
                              color: Colors.white,
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
                          );
                        },
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    SizedBox(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegisterScreen()),
                          );
                        },
                        child: Text(

                          'Create an account',
                          style: TextStyle(
                            fontSize: 20,
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
