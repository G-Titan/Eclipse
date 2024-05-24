import 'package:eclipse/conf/func/NeuralNetwork/flutter_Tensor.dart';
import 'package:flutter/material.dart';
import 'package:eclipse/conf/cloudsync.dart';
import 'package:eclipse/firebase_options.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart'; // Add this import for Firebase services
import 'package:firebase_auth/firebase_auth.dart'; // Add this import for Firebase authentication
import 'package:cloud_firestore/cloud_firestore.dart'; // Add this import for Firestore

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Check if the app is running in debug mode
  if (kDebugMode) {
    // Connect to Firebase local emulator
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseAuth.instance.useAuthEmulator('localhost', 4425);
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 4436);
  }

  runApp(const GodlyTouch());
}

class GodlyTouch extends StatelessWidget {
  const GodlyTouch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eclipse',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Colors.black,
        canvasColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LearnTheUser(),
    );
  }
}

class LearnTheUser extends StatefulWidget {
  const LearnTheUser({Key? key}) : super(key: key);

  @override
  _LearnTheUserState createState() => _LearnTheUserState();
}

class _LearnTheUserState extends State<LearnTheUser> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isRegisterMode = true;
  bool isTfModelInitialized =
      false; // Indicator for TensorFlow model initialization status

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Power Stone',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: const Color.fromARGB(73, 56, 12, 75),
                        elevation: 0,
                        content: SingleChildScrollView(
                          child: StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter setState) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: Image.asset(
                                        'lib/conf/assets/animations/purpleFlame.gif',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(height: 16),
                                        GestureDetector(
                                          onVerticalDragDown: (_) {},
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                icon: const Icon(
                                                    Icons.drag_handle,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                isRegisterMode
                                                    ? 'Register'
                                                    : 'Login',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {},
                                                icon: const Icon(
                                                    Icons.drag_handle,
                                                    color: Colors.transparent),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        TextFormField(
                                          controller: _emailController,
                                          decoration: const InputDecoration(
                                            labelText: 'Username',
                                            labelStyle:
                                                TextStyle(color: Colors.white),
                                            border: OutlineInputBorder(),
                                          ),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        const SizedBox(height: 16),
                                        TextFormField(
                                          controller: _passwordController,
                                          obscureText: true,
                                          decoration: const InputDecoration(
                                            labelText: 'Password',
                                            labelStyle:
                                                TextStyle(color: Colors.white),
                                            border: OutlineInputBorder(),
                                          ),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        const SizedBox(height: 16),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Login',
                                              style: TextStyle(
                                                color: isRegisterMode
                                                    ? Colors.grey
                                                    : Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Switch(
                                              value: isRegisterMode,
                                              onChanged: (value) {
                                                setState(() {
                                                  isRegisterMode = value;
                                                });
                                              },
                                              activeColor: Colors.purple,
                                              inactiveThumbColor: Colors.grey,
                                            ),
                                            Text(
                                              'Register',
                                              style: TextStyle(
                                                color: !isRegisterMode
                                                    ? Colors.grey
                                                    : Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 16),
                                        ElevatedButton(
                                          onPressed: () async {
                                            try {
                                              if (isRegisterMode) {
                                                String email = _emailController
                                                    .text
                                                    .trim();
                                                String password =
                                                    _passwordController.text
                                                        .trim();
                                                await CloudSync
                                                    .registerUserBasic(context,
                                                        email, password);
                                              } else {
                                                String email = _emailController
                                                    .text
                                                    .trim();
                                                String password =
                                                    _passwordController.text
                                                        .trim();
                                                await CloudSync.signInUser(
                                                    context, email, password);
                                              }
                                              // Initialize TensorFlow model here
                                              await TensorFlowService
                                                  .initializeTfModel();
                                              setState(() {
                                                // Update initialization status
                                                isTfModelInitialized = true;
                                              });
                                            } catch (error) {
                                              // Handle any errors during registration/login
                                              // For simplicity, just print the error here
                                              print(error.toString());
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.purple,
                                          ),
                                          child: Text(
                                            isRegisterMode
                                                ? 'Proceed'
                                                : 'Enter',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        // Text indicator for TensorFlow model initialization status
                                        Text(
                                          isTfModelInitialized
                                              ? ''
                                              : '⚠️Lavender is currently down',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                ),
                child: const Text(
                  'Start',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
