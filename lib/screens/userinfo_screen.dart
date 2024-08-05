import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:intl/intl.dart';

import '../services/database_service.dart';
import '../screens/main_screen.dart';
import '../classes/app_user.dart';

class UserInfoComponent extends StatefulWidget {
  static const String routeName = '/userinfo';
  UserInfoComponent({super.key});

  @override
  _UserInfoComponentState createState() => _UserInfoComponentState();
}

class _UserInfoComponentState extends State<UserInfoComponent> {

  // ********************************* Instance ********************************* //
  DatabaseService _databaseService = DatabaseService();

  // ********************************* Variables ********************************* //

  PlatformFile? pickedFile;

  DateTime selectedDate = DateTime.now();

  final _formKey = GlobalKey<FormState>();

  TextEditingController _dateController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  TextEditingController _weightController = TextEditingController();

  String imageUserURL_default = '';
  // ********************************* Methodes ********************************* //

  @override
  void initState() {
    super.initState();
    _databaseService.loadImage("files/app_assets/boyuser.png").then((value) {
      setState(() {
        imageUserURL_default = value!;
      });
    });
  }

  Future<void> getImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future<void> submitButton() async {

    if(pickedFile != null) _databaseService.uploadFile(pickedFile!);

    if (_formKey.currentState!.validate()) {
      await _databaseService.updateUser(
        Appuser(
          name: _nameController.text,
          firstName: _firstNameController.text,
          biography: _bioController.text,
          weight: _weightController.text,
          birthDate: _dateController.text,
          firstConnection: false,
          imageURL: pickedFile != null ? pickedFile!.path : '',
        ),
      );
      Navigator.pushNamed(context, MainScreen.routeName);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Votre profil à été mis à jour avec succès !'),
        ),
      );
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Veuillez remplir tous les champs !'),
        ),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1940),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        DateFormat formatter = DateFormat('dd/MM/yyyy');
        _dateController.text =formatter.format(picked);
      });
    }
  }

  // ********************************* Scaffold ********************************* //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ModalBarrier(dismissible: false, color: Colors.blueGrey),
          Center(
            child: Card(
              elevation: 25.0,
              margin: EdgeInsets.all(20.0),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Compléter votre profil', style: TextStyle(fontSize: 30)),
                        SizedBox(height: 10),
                        Center(
                          child: CircleAvatar(
                            radius: 100,
                            backgroundImage: pickedFile != null
                                ? FileImage(File(pickedFile!.path!))
                                : NetworkImage(imageUserURL_default),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 130.0, left: 110.0),
                              child: IconButton.filled(
                                icon: Icon(Icons.edit, size: 25.0),
                                onPressed: getImage,
                                color: Colors.white,

                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty){
                              return 'Veuillez entrer un nom';
                            }
                            return null;
                          },
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Nom',
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty){
                              return 'Veuillez entrer un prénom';
                            }
                            return null;
                          },
                          controller: _firstNameController,
                          decoration: InputDecoration(
                            labelText: 'Prénom',
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty ||RegExp(r'^\d+([.,]\d+)?$').hasMatch(value) == false){
                              return 'Veuillez entrer un poids correcte';
                            }
                            return null;
                          },
                          controller: _weightController,
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          decoration: InputDecoration(
                            labelText: 'Poids',
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            prefixIcon: Icon(Icons.monitor_weight),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty){
                              return 'Veuillez entrer une date de naissance';
                            }
                            return null;
                          },
                          controller: _dateController,
                          decoration: InputDecoration(
                            labelText: 'Date de naissance',
                            filled: true,
                            prefixIcon: Icon(Icons.calendar_today),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                          readOnly: true,
                          onTap: () {
                            _selectDate(context);
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _bioController,
                          decoration: InputDecoration(
                            labelText: 'Biographie',
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            prefixIcon: Icon(Icons.description),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: submitButton,
                          child: Text('Soumettre'),
                          style: ElevatedButton.styleFrom(
                            elevation: 5.0,
                            backgroundColor: Colors.grey,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                            textStyle: TextStyle(
                              fontSize: 24,
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
        ],
      ),
    );
  }
}
