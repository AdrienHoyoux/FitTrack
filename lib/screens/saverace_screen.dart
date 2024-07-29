import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myappflutter/classes/race.dart';
import '../services/database_service.dart';

class SaveRaceScreen extends StatefulWidget {
  static const routeName = '/saveRace';
  final Race course;

  SaveRaceScreen({required this.course});

  @override
  State<SaveRaceScreen> createState() => _SaveRaceScreenState();
}

class _SaveRaceScreenState extends State<SaveRaceScreen> {
  // ******************************** VARIABLES ******************************** //
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _distanceController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _speedController = TextEditingController();
  TextEditingController _caloriesController = TextEditingController();

  DatabaseService _databaseService = DatabaseService();

  // ******************************** METHODES ******************************** //
  Widget textFormField_saveScreen(String label, IconData icon, bool isReadOnly, TextEditingController controller, String unite) {
    return TextFormField(
      validator: (value) {
        if ((value == null || value.isEmpty) && !isReadOnly ) {
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

  void save_onPressed() async {
    if (_formKey.currentState!.validate()) {
      widget.course.name = _nameController.text;
      await _databaseService.addRace(widget.course);
      Navigator.pop(context);
    } else {
      SnackBar(content: Text('Veuillez entrer un nom pour votre course !'));
    }
  }

  @override
  void initState() {
    _nameController.text = '${widget.course.name}';
    _distanceController.text = '${widget.course.distance} ';
    _timeController.text = '${widget.course.time}';
    _speedController.text = '${widget.course.speed}';
    _caloriesController.text = '${widget.course.calories}';
    super.initState();
  }

  // ******************************** WIDGET ******************************** //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            'Sauvegarder votre course',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 50),
                          textFormField_saveScreen('Entrer le nom de la course...', Icons.sports_score_outlined, false, _nameController, ''),
                          SizedBox(height: 20),
                          textFormField_saveScreen('Distance: ', Icons.directions_run_outlined, true, _distanceController, 'm'),
                          SizedBox(height: 20),
                          textFormField_saveScreen('Durée: ', Icons.timer_outlined, true, _timeController, ''),
                          SizedBox(height: 20),
                          textFormField_saveScreen('Vitesse: ', Icons.speed_outlined, true, _speedController, 'km/h'),
                          SizedBox(height: 20),
                          textFormField_saveScreen('Calories: ', Icons.monitor_weight_outlined, true, _caloriesController, 'kcal'),
                          SizedBox(height: 40),
                          ElevatedButton(
                            onPressed: () {
                              save_onPressed();
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
                            child: Text('Sauvegarder'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
