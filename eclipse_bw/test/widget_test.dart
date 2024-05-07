import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:eclipse/main.dart';

void main() {
  // Unit tests

  test('Adds two numbers', () {
    expect(1 + 2, equals(3));
  });

  // Widget tests

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const GodlyTouch());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  // Integration tests

  testWidgets('End-to-end test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const GodlyTouch());

    // Find the text field and enter some text.
    await tester.enterText(find.byType(TextField), 'some text');

    // Trigger a frame to update the UI.
    await tester.pump();

    // Verify that the text is displayed.
    expect(find.text('some text'), findsOneWidget);
  });
}
