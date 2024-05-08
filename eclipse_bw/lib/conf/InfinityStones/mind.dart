import 'package:eclipse/conf/CloudSync.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Mind extends StatefulWidget {
  const Mind({super.key});

  @override
  _MindState createState() => _MindState();
}

class _MindState extends State<Mind> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _controllers = [
    TextEditingController(), // Name
    TextEditingController(), // Surname
    TextEditingController(), // Age
    TextEditingController(), // ID Number
    TextEditingController(), // Home Address
    TextEditingController(), // Phone Number
    TextEditingController(), // Citizenship
  ];
  final List<String> _labels = [
    'Name',
    'Surname',
    'Age',
    'ID Number',
    'Home Address',
    'Phone Number',
    'Citizenship',
  ];
  int _currentIndex = 0;
  final bool _isMale = false;
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KYC, Terms & Conditions',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(10.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(10.0),
          ),
          fillColor: Colors.white,
          filled: true,
          labelStyle: const TextStyle(color: Colors.blue),
        ),
      ),
      home: Scaffold(
        backgroundColor: Colors.transparent, // Set background color
        appBar: AppBar(
          backgroundColor:
              Colors.black, // Set the background color of the AppBar to black
          title: Text(
            'Registration Phase ${_currentIndex + 1}/7',
            style: const TextStyle(color: Colors.white), // Set text color to white
          ),
        ),

        body: Stack(
          children: [
            // Add your GIF animation here
            Image.asset(
              'lib/conf/assets/animations/powerStone.gif',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildTextField(
                        controller: _controllers[_currentIndex],
                        label: _labels[_currentIndex],
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (_currentIndex > 0)
                            ElevatedButton(
                              onPressed: _previousField,
                              child: const Text('Previous'),
                            ),
                          const SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: _nextField,
                            child: Text(_currentIndex == _controllers.length - 1
                                ? 'Submit'
                                : 'Next'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your $label';
          }
          return null;
        },
      ),
    );
  }

  void _nextField() {
    if (_formKey.currentState!.validate()) {
      if (_currentIndex < _controllers.length - 1) {
        setState(() {
          _currentIndex++;
        });
      } else {
        _submitForm();
      }
    }
  }

  void _previousField() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
    }
  }

  void _submitForm() {
    // Extract user data from the form fields
    String name = _controllers[0].text;
    String surname = _controllers[1].text;
    int age = int.parse(_controllers[2].text);
    String idNumber = _controllers[3].text;
    String homeAddress = _controllers[4].text;
    String phoneNumber = _controllers[5].text;
    String citizenship = _controllers[6].text;
    String gender = _isMale ? 'Male' : 'Female';
    String birthDate = _selectedDate != null
        ? '${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}'
        : '';

    // Call CloudSync method to register user details
    CloudSync.registerUserDetails(
      context,
      FirebaseAuth.instance.currentUser!.uid,
      name,
      surname,
      age,
      idNumber,
      homeAddress,
      phoneNumber,
      citizenship,
      gender,
      birthDate,
    );
  }
}
