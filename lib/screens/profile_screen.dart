import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = '/profile';
  ProfileScreen({super.key});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEditingEmail = false;
  bool isEditingDateOfBirth = false;
  bool isEditingWeight = false;
  bool isEditingHeight = false;
  bool isEditingGoal = false;

  TextEditingController emailController = TextEditingController(text: 'user@example.com');
  TextEditingController dobController = TextEditingController(text: '01/01/2000');
  TextEditingController weightController = TextEditingController(text: '70 kg');
  TextEditingController heightController = TextEditingController(text: '180 cm');
  TextEditingController goalController = TextEditingController(text: 'Stay fit');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile',style: TextStyle(color: Colors.white,fontSize: 30.0,fontWeight: FontWeight.bold ),),
        backgroundColor: Colors.black45,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage('assets/images/boyuser.png'), // Assurez-vous que l'image est dans le dossier assets et mentionnée dans pubspec.yaml
                ),
                SizedBox(height: 20),
                Text(
                  'John Doe',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                buildEditableField(
                  'Adresse e-mail',
                  emailController,
                  isEditingEmail,
                      () {
                    setState(() {
                      isEditingEmail = !isEditingEmail;
                    });
                  },
                ),
                SizedBox(height: 20),
                buildEditableField(
                  'Date de naissance',
                  dobController,
                  isEditingDateOfBirth,
                      () {
                    setState(() {
                      isEditingDateOfBirth = !isEditingDateOfBirth;
                    });
                  },
                ),
                SizedBox(height: 20),
                buildEditableField(
                  'Poids',
                  weightController,
                  isEditingWeight,
                      () {
                    setState(() {
                      isEditingWeight = !isEditingWeight;
                    });
                  },
                ),
                SizedBox(height: 20),
                buildEditableField(
                  'Taille',
                  heightController,
                  isEditingHeight,
                      () {
                    setState(() {
                      isEditingHeight = !isEditingHeight;
                    });
                  },
                ),
                SizedBox(height: 20),
                buildEditableField(
                  'Objectif',
                  goalController,
                  isEditingGoal,
                      () {
                    setState(() {
                      isEditingGoal = !isEditingGoal;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEditableField(String label, TextEditingController controller, bool isEditing, VoidCallback onEditIconPressed) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey[700],
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: isEditing
                  ? TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Enter $label',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
                  : Text(
                controller.text,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ),
            IconButton(
              icon: Icon(isEditing ? Icons.check : Icons.edit, color: Colors.black),
              onPressed: onEditIconPressed,
            ),
          ],
        ),
      ],
    );
  }
}

