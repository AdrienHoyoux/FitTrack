import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool showLabel;
  final bool showTooltip;
  final String labelText;
  final String tooltipMessage;

  const PasswordField({
    Key? key,
    required this.controller,
    this.showLabel = false,
    this.showTooltip = false,
    this.labelText = 'Mot de passe',
    this.tooltipMessage = 'Le mot de passe doit contenir au moins 6 caractères',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel)
          Row(
            children: [
              Text(
                labelText,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              if (showTooltip) ...[
                SizedBox(width: 10),
                Tooltip(
                  message: tooltipMessage,
                  child: Icon(Icons.help, size: 25.0, color: Colors.white),
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
                  margin: EdgeInsets.only(left: 150, right: 20),
                ),
              ]
            ],
          ),
        SizedBox(height: showLabel ? 20 : 0),
        Center(
          child: SizedBox(
            width: 320,
            height: 80,
            child: TextFormField(
              controller: controller,
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 6) {
                  return 'Veuillez entrer un mot de passe valide !';
                }
                return null;
              },
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Entrer votre mot de passe...',
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
      ],
    );
  }
}
