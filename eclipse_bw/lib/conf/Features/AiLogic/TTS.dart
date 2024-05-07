import 'package:flutter/material.dart';

class Heart extends StatelessWidget {
  const Heart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Ask & you shall receive💯',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: 300,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Type your question here...',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
