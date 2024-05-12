import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';

class Heart extends StatefulWidget {
  const Heart({Key? key}) : super(key: key);

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

  // Generate a response based on keywords/topics.
  String generateResponse(String userInput) {
    // Define a map of predefined responses based on specific keywords or topics.
    Map<String, List<String>> topicResponses = {
      'greeting': [
        'Hello!',
        'Hi there!',
        'Nice to meet you!',
        'dumelang a o tsogile sentle gompieno?'
      ],
      'bocheki': [
        'Ola',
        'Eita',
        'dintshang brazen?',
        'Aaah go iketilwe ntwana ne o reng fela?'
      ],
      'thanks': [
        'You\'re welcome!',
        'No problem, happy to help!',
        'Anytime!',
        'Ke a leboga!'
      ],
      'plans': ['Ga se gore re ye go plan one-nyana?'],
      'intro': [
        'I am Lavender, I am still in construction but feel free to chat with me while my maker wipes my ass for now '
      ],
      'statusCheck': [
        'I felt a bug slither through me... urg😫 so unconfortable😭call my master!',
        'just chillin bro',
        'All systems go!'
      ],
      'wellbeingSetswana': [
        'Ao? nna ke iketile mme kana😴 ga se gore re ye go plan one-nyana?'
      ],
      'nothingSetswana': ['Sepe fela', 'Aaah go maswe waitse'],
      'searchingForLove': [
        'Ga maswe gompieno ke bona mangwanda fela😒💔',
        'Ke ba tlogetse ko dladleng ba nkemetse ebile😏',
        'O ta ba bona jang o bua le nna🤷‍♀️?'
      ],

      // Add more topics and corresponding responses as needed.
    };

    // Check the user's input for keywords or topics.
    String responseTopic;
    if (userInput.contains('hello') ||
        userInput.contains('Hi') ||
        userInput.contains('Hello') ||
        userInput.contains('Hey') ||
        userInput.contains('Dumela') ||
        userInput.contains('hi') ||
        userInput.contains('morning') ||
        userInput.contains('evening') ||
        userInput.contains('afternoon') ||
        userInput.contains('hey') ||
        userInput.contains('dumela')) {
      responseTopic = 'greeting';
      // YES or NO
    } else if (userInput.contains('Ee') ||
        userInput.contains('Nyaa') ||
        userInput.contains('ee') ||
        userInput.contains('nyaa')) {
      responseTopic = 'wellbeingSetswana';
      // Making a plan
    } else if (userInput.contains('iketilwe') ||
        userInput.contains('iketliwe')) {
      responseTopic = 'plans';
      // Gratitude
    } else if (userInput.contains('thank')) {
      responseTopic = 'thanks';
      // About the app
    } else if (userInput.contains('this website') ||
        userInput.contains('yourself?') ||
        userInput.contains('about yourself') ||
        userInput.contains('about you') ||
        userInput.contains('is this?')) {
      responseTopic = 'intro';
      // Turn-Up
    } else if (userInput.contains('siama') ||
        userInput.contains('Ao') ||
        userInput.contains('borega') ||
        userInput.contains('bora') ||
        userInput.contains('bonya') ||
        userInput.contains('ao') ||
        userInput.contains('Siama')) {
      responseTopic = 'plans';
      // local slang
    } else if (userInput.contains('Ola') ||
        userInput.contains('Eita') ||
        userInput.contains('eita') ||
        userInput.contains('ola')) {
      responseTopic = 'bocheki';
      // user asking for plans
    } else if (userInput.contains('dintshang') ||
        userInput.contains('Dinsthang') ||
        userInput.contains('plan ke') ||
        userInput.contains('style ke') ||
        userInput.contains('kae plan?') ||
        userInput.contains('wareng')) {
      responseTopic = 'nothingSetswana';
      // status check
    } else if (userInput.contains('are you') ||
        userInput.contains('O teng fela') ||
        userInput.contains('o teng fela')) {
      responseTopic = 'statusCheck';
      // finding love
    } else if (userInput.contains('bana') || userInput.contains('girls at')) {
      responseTopic = 'searchingForLove';
    } else {
      // If no specific topic is found, use a generic response.
      responseTopic = 'default';
    }

    // Get a random response from the chosen topic or use a generic one.
    List<String> responses = topicResponses[responseTopic] ??
        ['🤔Hmm... tough one couldnt find an answer for you'];
    int index = Random().nextInt(responses.length);
    return responses[index];
  }
}
