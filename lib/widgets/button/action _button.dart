import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double fontSize;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;
  final double elevation;
  final double borderRadius;

  const ActionButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.fontSize = 25.0,
    this.backgroundColor = Colors.black45,
    this.foregroundColor = Colors.white,
    this.borderColor = Colors.blueGrey,
    this.elevation = 0.0,
    this.borderRadius = 10.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 250,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
          ),
        ),
        style: ElevatedButton.styleFrom(
          elevation: elevation,
          foregroundColor: foregroundColor,
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(
              color: borderColor,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
