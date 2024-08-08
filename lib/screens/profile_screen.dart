import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../classes/app_user.dart';
import '../services/database_service.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  static String routeName = '/profile';
  ProfileScreen({super.key});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  // **************************** VARIABLES **************************** //
  String _imageUserURL_default = '';
  PlatformFile? pickedFile;
  TextEditingController _biographyController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  // ***************************** Instance **************************** //
  DatabaseService _databaseService = DatabaseService();

  // **************************** METHODES **************************** //
  String calculAge(String date) {
    DateTime now = DateTime.now();
    DateFormat format = DateFormat("dd/MM/yyyy");
    DateTime birthDate = format.parse(date);

    int age = now.year - birthDate.year;
    if (now.month < birthDate.month || (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }

    return age.toString();
  }

  @override
  void initState() {
    super.initState();
    _databaseService.loadImage("files/app_assets/boyuser.png").then((value) {

      setState(() {
        _imageUserURL_default = value!;
      });
    });

    _databaseService.getCurrentUser().then((value) {
      if (value != null) {
        setState(() {
          _biographyController.text = value.biography!;
          _weightController.text = value.weight!;
          _ageController.text = calculAge(value.birthDate!);
        });
      }
    });
  }

  Future<void> getImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });

    if (pickedFile != null) {
      await _databaseService.uploadFile(pickedFile!);
    }
  }

  // **************************** Scaffold **************************** //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Profil utilisateur',style: TextStyle(color: Colors.white,fontSize: 30.0,fontWeight: FontWeight.bold ),),
            backgroundColor: Colors.black45,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            )
        ),
        body: FutureBuilder<Appuser?>(
          future: _databaseService.getCurrentUser(),
          builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator());
            }
            else if(snapshot.hasError) {
              return SnackBar(content: Text('Erreur : ${snapshot.error}'));
            }
            else if (snapshot.hasData) {
              Appuser? user = snapshot.data;
              if (user != null) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child:Padding(
                          padding: const EdgeInsets.only(top:15.0),
                          child: CircleAvatar(
                            radius: 100,
                            backgroundImage : user.imageURL == ""
                                ? NetworkImage(_imageUserURL_default)
                                : (pickedFile != null
                                ? FileImage(File(pickedFile!.path!))
                                : NetworkImage(user.imageURL!)),
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
                      ),
                      SizedBox(height: 20),
                      Text(
                        '${user.firstName} ${user.name}',
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Card(
                          elevation: 5,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding : EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Text("Informations personnelles",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                                SizedBox(height: 20),
                                Form(
                                  key: _formkey,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Age",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                      SizedBox(height: 10),
                                      TextFormField(
                                        readOnly: true,
                                        controller: _ageController,
                                        style: TextStyle(color: Colors.black),
                                        decoration: InputDecoration(
                                          icon: Icon(Icons.calendar_month),
                                          filled: true,
                                          suffixText: 'Ans',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.blue),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text("Poids",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                      SizedBox(height: 10),
                                      TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty || RegExp(r'^[0-9]+$').hasMatch(value) == false){
                                            return 'Veuillez entrer votre poids';
                                          }
                                          return null;
                                        },
                                        controller : _weightController,
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(color: Colors.black),
                                        decoration: InputDecoration(
                                          icon: Icon(Icons.balance),
                                          filled: true,
                                          suffixText: 'Kg',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.blue),
                                          ),
                                        ),
                                        onChanged: (value) async {
                                          if(_formkey.currentState!.validate()) {
                                            user.weight = value;
                                          }
                                        },
                                      ),
                                      SizedBox(height: 10),
                                      Text("Biographie",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                      SizedBox(height: 20),
                                      TextFormField(
                                        validator: (value) {
                                          if (value!.length > 84 ) {
                                            return 'Votre biographie ne doit pas \ndépasser 84 caractères';
                                          }
                                          return null;
                                        },
                                        controller : _biographyController,
                                        maxLines: 3,
                                        decoration: InputDecoration(
                                          icon: Icon(Icons.book),
                                          filled: true,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.blue),
                                          ),
                                        ),
                                        onChanged: (value) async {
                                          if(_formkey.currentState!.validate()){
                                            user.biography = value;
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          )
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          await _databaseService.updateUser(user);
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 5.0,
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                          textStyle: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        child: Text('Enregistrer',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                );
              }
              else {
                return Center(child: Text('Pas de données utilisateur trouvées'));
              }
            }
            else {
              return Center(child: Text('Pas de d\'utilisateur trouvé'));
            }

          },
        )
    );
  }
}
