import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final TextDecoration decoration;
  final Color decorationColor;
  final double decorationThickness;
  final double fontSize;
  final Color textColor;
  final double width;
  final double height;

  const CustomTextButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.decoration = TextDecoration.none,
    this.decorationColor = Colors.transparent,
    this.decorationThickness = 1.0,
    this.fontSize = 20.0,
    this.textColor = Colors.black,
    this.width = 250.0,
    this.height = 50.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            decoration: decoration,
            decorationColor: decorationColor,
            decorationThickness: decorationThickness,
            fontSize: fontSize,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
