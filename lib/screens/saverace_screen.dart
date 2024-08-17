import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:FitTrack/classes/race.dart';
import 'package:FitTrack/widgets/buttons/action%20_button.dart';
import 'package:FitTrack/widgets/field/saverace_field.dart';
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
  bool waiting = false;

  // ******************************** INSTANCES ******************************** //
  DatabaseService _databaseService = DatabaseService();

  // ******************************** METHODES ******************************** //
  void save_onPressed() async {
    setState(() {
      waiting = true;
    });
    if (_formKey.currentState!.validate()) {
      widget.course.name = _nameController.text;
      await _databaseService.addRace(widget.course);
      Navigator.pop(context);
    } else {
      SnackBar(content: Text('Veuillez entrer un nom pour votre course !'));
    }
    setState(() {
      waiting = false;
    });
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
                          SaveraceField(label: 'Entrer le nom de la course...', icon: Icons.sports_score_outlined, isReadOnly: false, controller: _nameController, unite: ''),
                          SizedBox(height: 20),
                          SaveraceField(label: 'Distance: ', icon: Icons.directions_run_outlined, isReadOnly: true, controller:_distanceController, unite: 'm'),
                          SizedBox(height: 20),
                          SaveraceField(label: 'Durée', icon: Icons.timer_outlined, isReadOnly: true, controller: _timeController, unite: ''),
                          SizedBox(height: 20),
                          SaveraceField(label: 'Vitesse: ', icon: Icons.speed_outlined, isReadOnly: true, controller: _speedController, unite: 'km/h'),
                          SizedBox(height: 20),
                          SaveraceField(label: 'Calories: ', icon:  Icons.monitor_weight_outlined, isReadOnly: true, controller: _caloriesController, unite: 'kcal'),
                          SizedBox(height: 40),
                          ActionButton(
                              onPressed: save_onPressed,
                              text: 'Sauvegarder',
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: waiting
                                ? CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                                  )
                                : null,
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
