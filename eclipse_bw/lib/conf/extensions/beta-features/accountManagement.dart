import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore library

class UserManagement extends StatelessWidget {
  final String userId;

  const UserManagement({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get(), // Fetch user data
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show loading indicator while data is being fetched
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); // Show error if any
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return const Text(
              'User not found'); // Handle case where user data is not available
        }

        // Retrieve user data from snapshot
        final userData = snapshot.data!.data() as Map<String, dynamic>?;

        if (userData == null) {
          return const Text('An error occured while fetching your account');
        }

        // Access name and surname fields from userData
        final String? name = userData['name'] as String?;
        final String? surname = userData['surname'] as String?;

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display user's name
            Text('Name: $name'),
            // Display user's surname
            Text('Surname: $surname'),
            // Add logic or buttons as needed
          ],
        );
      },
    );
  }
}
