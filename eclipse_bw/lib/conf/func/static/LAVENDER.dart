import 'dart:async';
import 'package:flutter/material.dart';
import 'package:eclipse/conf/func/static/chatbot.dart';

class LAVENDER extends StatefulWidget {
  const LAVENDER({Key? key}) : super(key: key);

  @override
  State<LAVENDER> createState() => _HeartState();
}

class _HeartState extends State<LAVENDER> {
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
          // Generate a response based on keywords/topics.
          String response = generateResponse(userInput);

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
                  hintText: 'Start typing...',
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (response.isNotEmpty)
              Column(
                children: [
                  Text(
                    response,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  if (response.contains(
                      'one nyana')) // Condition for displaying buttons for one response
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Add logic for 'Yes' button
                          },
                          child: const Text('Yes'),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: () {
                            // Add logic for 'No' button
                          },
                          child: const Text('No'),
                        ),
                      ],
                    ),
                  if (response.contains(
                      'you with one')) // Condition for displaying buttons for another response
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Add logic for button
                          },
                          child: const Text('18+ room'),
                        ),
                      ],
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
