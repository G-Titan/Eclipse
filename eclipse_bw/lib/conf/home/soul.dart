import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class Soul extends StatelessWidget {
  final String? userId;

  const Soul({super.key, this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
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
                Text('Citizenship: ${userData['citizenship']}'),
                Text('Gender: ${userData['gender']}'),
                Text('Birth Date: ${userData['birthDate']}'),
              ],
            );
          },
        ),
      ),
    );
  }
}
