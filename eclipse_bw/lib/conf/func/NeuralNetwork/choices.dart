import 'package:flutter/material.dart';

class ChoiceButtons extends StatelessWidget {
  final String response;

  const ChoiceButtons({super.key, required this.response});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                },
                child: const Text('Help Improve'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  // Add logic for another button
                },
                child: const Text('Terms & conditions'),
              ),
            ],
          ),
        //
        //
        //// Add more button pairs as needed
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
