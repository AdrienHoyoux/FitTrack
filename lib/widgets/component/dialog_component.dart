import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:FitTrack/screens/main_screen.dart';

class DialogComponent extends StatelessWidget {
  final VoidCallback onPressed;
  final String routeName;
  final String content;
  final String title;
  final String text1;
  final String text2;
  final int? screenIndex; // Ajout d'un paramètre optionnel pour l'index

  const DialogComponent({
    Key? key,
    required this.onPressed,
    required this.content,
    required this.title,
    required this.text1,
    required this.text2,
    required this.routeName,
    this.screenIndex, // Paramètre d'index optionnel
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(this.title),
      content: Text(this.content),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(this.text1),
        ),
        TextButton(
          onPressed: () {
            onPressed();
            if (routeName == '/main') {
              // Passer l'index du PerformanceScreen lors de la navigation
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainScreen(initialIndex: screenIndex ?? 0),
                ),
              );
            } else {
              Navigator.pushNamed(context, routeName);
            }
          },
          child: Text(this.text2),
        ),
      ],
    );
  }
}
