import 'package:flutter/material.dart';
import 'package:habbit_app/color_glonbal_onboard/color.dart'; // Import your color file

class AccountInfoPage extends StatefulWidget {
  @override
  _AccountInfoPageState createState() => _AccountInfoPageState();
}

class _AccountInfoPageState extends State<AccountInfoPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            hexStringToColor("CB2B93"), // Custom gradient colors
            hexStringToColor("9546C4"),
            hexStringToColor("5E61F4"),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor:
            Colors.transparent, // Transparent background to allow the gradient
        appBar: AppBar(
          title: Text("My Account Info"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                _buildTextField("Name", _nameController),
                _buildTextField("Father's Name", _fatherNameController),
                _buildTextField("Age", _ageController,
                    keyboardType: TextInputType.number),
                _buildTextField("Height (cm)", _heightController,
                    keyboardType: TextInputType.number),
                _buildTextField("Weight (kg)", _weightController,
                    keyboardType: TextInputType.number),
                _buildTextField("Phone Number", _phoneNumberController,
                    keyboardType: TextInputType.phone),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Handle form submission here
                      final name = _nameController.text;
                      final fatherName = _fatherNameController.text;
                      final age = _ageController.text;
                      final height = _heightController.text;
                      final weight = _weightController.text;
                      final phoneNumber = _phoneNumberController.text;

                      // Save the information to the database or server

                      Navigator.pop(
                          context); // Navigate back to the ProfilePage
                    }
                  },
                  child: Text("Save"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter $label";
          }
          return null;
        },
      ),
    );
  }
}
