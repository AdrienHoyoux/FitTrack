import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FitTrack',
      home: Scaffold(
        body:
            Column(
              children: [
                Container(
                    color: Colors.grey[600],
                    height: 281.0,
                    child: Center(
                        child: SizedBox(
                            width: 366.0,
                            height: 251.0,
                            child : Image.asset('assets/fittracklogo.png')
                        )
                    )
                ),
                SizedBox(
                  height: 540.0,
                  width: 420.0,
                  child: Container(
                    color: Colors.grey[500],
                    child : Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20.0),
                          height: 120,
                          child: Column(
                            children:[
                              Text('Welcome to FitTrack !',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32.0,
                                ),
                              ),
                              Text('Create an account or log in to FitTrack.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            ]
                          ) ,
                        ),
                        Container(
                          child :Column(
                            children: [
                              SizedBox(
                                width: 300.0,
                                height : 50.0,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/login');
                                  },
                                  child: Text('Log In',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.pink[100],),
                                  ),
                                ),
                              SizedBox(height: 30,),
                              SizedBox(
                                width: 300.0,
                                height : 50.0,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/signup');
                                  },
                                  child: Text('Sign Up',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.pink[100],),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 20.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Divider(
                                        color: Colors.white,
                                        thickness: 1,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Text(
                                        "OR",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Divider(
                                        color: Colors.white,
                                        thickness: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ]
                          )
                        ),
                        SizedBox(
                          height: 30.0,
                          child: Text('Use a service Tiers account',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white,
                              decorationThickness: 2.0,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: FaIcon(FontAwesomeIcons.gamepad),
                                iconSize: 50.0,
                                color: Colors.white,
                                onPressed: () {print("pressed !");},
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ),
                ),
                SizedBox(
                  height: 46.0,
                  width: 420.0,
                  child: Container(
                    color: Colors.grey[600],
                    child: Center(
                      child: Text(
                        '© 2024 FitTrack',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          )
      );
  }
}