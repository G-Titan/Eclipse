import 'package:flutter/material.dart';
import 'package:eclipse/about.dart';
import 'package:eclipse/conf/extensions/beta-features/accountManagement.dart';

class ChoiceButtons extends StatelessWidget {
  final String response;
  final String userId;

  const ChoiceButtons(
      {super.key, Key, required this.response, required this.userId});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (response.contains('one nyana') || response.contains('you with one'))
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
        // CONTRIBUTIONS
        if (response.contains('Good question') ||
            response.contains('paid for it!') ||
            response.contains('tough one'))
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Add logic for button
                  // Navigator.push(
                  // context,
                  //  MaterialPageRoute(builder: (context) => DigitalWalletConsole()),
                  // );
                },
                child: const Text('Help Improve'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AboutPage()),
                  );
                },
                child: const Text('Terms & conditions'),
              ),
            ],
          ),
        //// OFFERINGS
        if (response.contains('just a suggestion') ||
            response.contains('I thought I was'))
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Add logic for button
                },
                child: const Text('Offer something'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  // Add logic for another button
                },
                child: const Text('Next time'),
              ),
            ],
          ),
        if (response.contains(
            'tour of me')) // Condition for displaying buttons for another response
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Add logic for button
                },
                child: const Text('Yes'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  // Add logic for another button
                },
                child: const Text('No'),
              ),
            ],
          ),
        if (response.contains('and verify everything is up to date') ||
            response.contains('your account') ||
            response.contains(
                'account ya gago')) // Condition for displaying buttons for another response
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserManagement(userId: userId),
                    ),
                  );
                },
                child: const Text('Proceed'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  // Add logic for another button
                },
                child: const Text('Quit request'),
              ),
            ],
          ),
        ////// Add more button pairs as needed
        // if (response.contains('Another condition')) // Condition for displaying buttons for another response
        //   Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       ElevatedButton(
        //         onPressed: () {
        //           // Add logic for button
        //         },
        //         child: const Text('Button'),
        //       ),
        //       const SizedBox(width: 16),
        //       ElevatedButton(
        //         onPressed: () {
        //           // Add logic for another button
        //         },
        //         child: const Text('Another Button'),
        //       ),
        //     ],
        //   ),
      ],
    );
  }
}
