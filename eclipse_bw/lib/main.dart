// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:eclipse/conf/cloudsync.dart';
import 'package:eclipse/firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kDebugMode) {
    try {
      FirebaseAuth.instance.useAuthEmulator('localhost', 4435);
      FirebaseFirestore.instance.useFirestoreEmulator('localhost', 4446);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  runApp(const GodlyTouch());
}

class GodlyTouch extends StatelessWidget {
  const GodlyTouch({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eclipse',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor:
            Colors.black, // Set scaffold background to black
        canvasColor: Colors.black, // Set canvas color to black
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LearnTheUser(),
    );
  }
}

class LearnTheUser extends StatefulWidget {
  const LearnTheUser({super.key});

  @override
  _CreateAuthSessionState createState() => _CreateAuthSessionState();
}

class _CreateAuthSessionState extends State<LearnTheUser> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isRegisterMode = true;

  // Function to handle refresh action
  Future<void> _handleRefresh() async {
    // Clear text in text controllers
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: Scaffold(
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Power Stone',
                  style: TextStyle(
                    color: Colors.white, // Set text color to white
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
                                      // Your background GIF
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
                                            onVerticalDragDown:
                                                (_) {}, // Prevent dragging on header
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                      color:
                                                          Colors.transparent),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          TextFormField(
                                            controller: _emailController,
                                            decoration: const InputDecoration(
                                              labelText: 'Username',
                                              labelStyle: TextStyle(
                                                  color: Colors.white),
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
                                              labelStyle: TextStyle(
                                                  color: Colors.white),
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
                                            onPressed: () {
                                              if (isRegisterMode) {
                                                String email = _emailController
                                                    .text
                                                    .trim();
                                                String password =
                                                    _passwordController.text
                                                        .trim();
                                                CloudSync.registerUserBasic(
                                                    context, email, password);
                                              } else {
                                                String email = _emailController
                                                    .text
                                                    .trim();
                                                String password =
                                                    _passwordController.text
                                                        .trim();
                                                CloudSync.signInUser(
                                                    context, email, password);
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
                    backgroundColor: Colors.purple, // Define button color
                  ),
                  child: const Text(
                    'Start',
                    style: TextStyle(
                        color: Colors.white), // Set text color to white
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
