// library_private_types_in_public_api

// ignore_for_file: unused_field, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:eclipse/conf/corenav.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eclipse/conf/home/mind.dart';
import 'package:eclipse/conf/home/soul.dart';
import 'package:eclipse/conf/home/space.dart';
import 'package:eclipse/conf/home/time.dart';
import 'package:eclipse/conf/settings.dart';
import 'package:eclipse/conf/extensions/eclipse.dart';
//import 'package:citynest/about_page.dart';
//import 'package:citynest/conf/disndat.dart'; // Assuming this is where login/register logic is

class Power extends StatefulWidget {
  final String? userId; // Add userId parameter

  const Power({super.key, this.userId});

  @override
  _PowerState createState() => _PowerState();
}

class _PowerState extends State<Power> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Power(),
    const Soul(),
    const Space(),
    const Time(),
    const Mind()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Godly\'s Touch'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: GoogleFonts.pacifico(
          textStyle: const TextStyle(
              color: Colors.white, fontSize: 20, fontStyle: FontStyle.italic),
        ),
      ),
      drawer: CoreNav(navigateToPage: (index) {
        setState(() {
          _selectedIndex = index;
        });
        Navigator.of(context).pop();
      }),
      body: const PowerPageContent(),
    );
  }
}

class PowerPageContent extends StatefulWidget {
  const PowerPageContent({super.key});

  @override
  _PowerPageContentState createState() => _PowerPageContentState();
}

class _PowerPageContentState extends State<PowerPageContent> {
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    _checkSignInStatus();
  }

  Future<void> _checkSignInStatus() async {
    var user = FirebaseAuth.instance.currentUser;
    setState(() {
      _isSignedIn = user != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isSignedIn) {
      return PageView(
        children: const [
          EclipseAi(), // Keep EclipseAi if needed
          SettingsPage(), // Keep SettingsPage if needed
        ],
      );
    } else {
      // Return a widget indicating the user is not signed in
      return const Placeholder(); // Replace with your desired widget
    }
  }
}
