// ignore_for_file: camel_case_types

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class usermanagement extends StatelessWidget {
  final String userId;
  usermanagement({super.key, required this.userId});
  final bool isUserSignedIn = FirebaseAuth.instance.currentUser != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .snapshots(), // Fetch user data from Firestore
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            if (!snapshot.hasData || snapshot.data!.data() == null) {
              return const Center(
                child: Text('No user data found'),
              );
            }

            // Display user information from Firestore
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${userData['name']}'),
                Text('Surname: ${userData['surname']}'),
                Text('Age: ${userData['age']}'),
                Text('ID Number: ${userData['idNumber']}'),
                Text('Home Address: ${userData['homeAddress']}'),
                Text('Phone Number: ${userData['phoneNumber']}'),
              ],
            );
          },
        ),
      ),
    );
  }
}
