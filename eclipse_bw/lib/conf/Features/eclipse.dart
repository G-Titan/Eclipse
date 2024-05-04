import 'package:flutter/material.dart';

class EclipseAi extends StatelessWidget {
  const EclipseAi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        alignment: Alignment.center,
        child: const Text(
          'Lavender is being built...',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
