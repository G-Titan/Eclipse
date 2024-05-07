// ignore_for_file: unused_import

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class Heart extends StatefulWidget {
  const Heart({super.key});

  @override
  State<Heart> createState() => _HeartState();
}

class _HeartState extends State<Heart> {
  final TextEditingController _textEditingController = TextEditingController();
  Timer? _timer;
  String response = '';

  @override
  void initState() {
    super.initState();

    // Listen for changes to the text field.
    _textEditingController.addListener(() {
      // Reset the timer when the user starts typing again.
      if (_timer != null) {
        _timer!.cancel();
      }

      // Start a new timer when the user stops typing.
      _timer = Timer(const Duration(seconds: 4), () {
        // Get the user input from the TextEditingController.
        String userInput = _textEditingController.text;

        // Log the user input into the console.
        print('User input: $userInput');

        // Check if the input field is not empty.
        if (userInput.isNotEmpty) {
          // Generate a random response.
          String response = generateResponse();

          // Display the response to the user via text.
          setState(() {
            this.response = response;
            _textEditingController
                .clear(); // Clear the text field after a response is given.
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Ask & you shall receive💫',
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
              child: TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Share with me what\'s on your mind.',
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (response.isNotEmpty)
              Text(
                response,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }

  String generateResponse() {
    // List of possible responses.
    List<String> responses = [
      'Interesting question!',
      'I see what you mean.',
      'Let me think about that for a moment.',
      'That\'s a tough one!',
      'I appreciate your input!',
    ];

    // Get a random index to select a response.
    int index = Random().nextInt(responses.length);

    // Return the selected response.
    return responses[index];
  }
}
