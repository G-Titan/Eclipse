import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:eclipse/conf/cloudsync.dart';
import 'package:eclipse/conf/extensions/beta-features/accountManagement.dart';

class CoreNav extends StatelessWidget {
  final Function(int) navigateToPage;
  final String? userId; // Added userId parameter
  final User? currentUser = FirebaseAuth.instance.currentUser;

  CoreNav(
      {super.key,
      required this.navigateToPage,
      this.userId}); // Updated constructor

  final bool isUserSignedIn = FirebaseAuth.instance.currentUser != null;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.purple,
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          children: [
            if (isUserSignedIn) ...[
              ListTile(
                leading: const Icon(Icons.account_circle, color: Colors.white),
                title: FutureBuilder<DocumentSnapshot?>(
                  future: getUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text('Loading...',
                          style: TextStyle(color: Colors.white));
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}',
                          style: const TextStyle(color: Colors.white));
                    } else {
                      var userName = snapshot.data?['name'];
                      if (userName != null && userName.isNotEmpty) {
                        return Text('$userName',
                            style: const TextStyle(color: Colors.white));
                      } else {
                        return const Text('Guest',
                            style: TextStyle(color: Colors.white));
                      }
                    }
                  },
                ),
                onTap: () {
                  if (currentUser != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            usermanagement(userId: currentUser!.uid),
                      ),
                    );
                  } else {
                    // Handle the case when the user is not signed in
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.music_note, color: Colors.white),
                title:
                    const Text('Media', style: TextStyle(color: Colors.white)),
                onTap: () => navigateToPage(1),
              ),
              ListTile(
                leading: const Icon(Icons.settings, color: Colors.white),
                title: const Text('Settings',
                    style: TextStyle(color: Colors.white)),
                onTap: () => navigateToPage(2),
              ),
              ListTile(
                leading: const Icon(Icons.help_outline, color: Colors.white),
                title:
                    const Text('Help', style: TextStyle(color: Colors.white)),
                onTap: () => navigateToPage(3),
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.white),
                title:
                    const Text('Logout', style: TextStyle(color: Colors.white)),
                onTap: () => CloudSync.signOut(context),
              ),
            ],
            Expanded(child: Container()),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: FloatingActionButton(
                onPressed: () {
                  // Placeholder for action, e.g., switching themes
                },
                backgroundColor: Colors.white,
                child: const Icon(Icons.wb_sunny, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<DocumentSnapshot?> getUserData() async {
    // Get the current user's ID
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      // Fetch user data from Firestore using the user's ID
      DocumentSnapshot snapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      return snapshot;
    } else {
      // Return null if the user is not signed in
      return null;
    }
  }
}
