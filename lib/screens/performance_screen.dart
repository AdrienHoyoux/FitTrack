import 'package:flutter/material.dart';

class PerformanceScreen extends StatefulWidget {

  static const String routeName = '/performance';
  PerformanceScreen({super.key});
  @override
  _PerformanceScreenState createState() => _PerformanceScreenState();
}

class _PerformanceScreenState extends State<PerformanceScreen> {

  @override
  Widget build(BuildContext context){
    return Scaffold(

     body: Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
           Text('Performance',style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,color: Colors.black),),
         ],
       ),
     ),
    );
  }
}