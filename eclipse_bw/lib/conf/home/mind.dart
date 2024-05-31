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
  bool _isMale = true;
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
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('KYC, Terms & Conditions'),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/conf/assets/animations/powerStone.gif'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildPhaseIndicator(),
                    _buildCurrentField(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: _previousField,
                          child: const Text('Previous'),
                        ),
                        TextButton(
                          onPressed: _nextField,
                          child: Text(
                            _currentIndex == _controllers.length + 1
                                ? 'Submit'
                                : 'Next',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhaseIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        'Phase ${_currentIndex + 1} of ${_controllers.length + 2}',
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildCurrentField() {
    if (_currentIndex < _controllers.length) {
      return _buildTextField(
        controller: _controllers[_currentIndex],
        label: _labels[_currentIndex],
      );
    } else if (_currentIndex == _controllers.length) {
      return _buildGenderToggle();
    } else if (_currentIndex == _controllers.length + 1) {
      return _buildDatePicker();
    }
    return Container();
  }

  Widget _buildGenderToggle() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Are you a (Man, boy) or (Woman, girl)?',
          style: TextStyle(color: Colors.white),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Male',
              style: TextStyle(color: Colors.white),
            ),
            Switch(
              value: _isMale,
              onChanged: (bool value) {
                setState(() {
                  _isMale = value;
                });
              },
            ),
            const Text(
              'Female',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDatePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () async {
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );
            if (picked != null) {
              setState(() {
                _selectedDate = picked;
              });
            }
          },
          child: Text(
            _selectedDate == null
                ? 'Select birth date'
                : _selectedDate.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
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
          labelStyle: const TextStyle(color: Colors.white),
        ),
        style: const TextStyle(color: Colors.white),
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
      if (_currentIndex < _controllers.length + 1) {
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
    int idNumber = int.parse(_controllers[3].text);
    String homeAddress = _controllers[4].text;
    int phoneNumber = int.parse(_controllers[5].text);
    String citizenship = _controllers[6].text;
    String gender = _isMale ? 'Male' : 'female';
    String birthDate = _selectedDate?.toString() ?? '';

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
