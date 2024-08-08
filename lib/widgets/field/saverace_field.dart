import 'package:flutter/material.dart';

class SaveraceField extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isReadOnly;
  final TextEditingController controller;
  final String unite;

  const SaveraceField({
    Key? key,
    required this.label,
    required this.icon,
    required this.isReadOnly,
    required this.controller,
    required this.unite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if ((value == null || value.isEmpty) && !isReadOnly) {
          return 'Veuillez entrer un nom pour votre course !';
        }
        return null;
      },
      readOnly: isReadOnly,
      controller: controller,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        suffixText: unite,
        labelStyle: TextStyle(color: Colors.grey),
        icon: Icon(icon),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
    );
  }
}
