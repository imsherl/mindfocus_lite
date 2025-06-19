// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:mindfocus_lite/main.dart';

void main() {
  testWidgets('MindFocus Lite app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MindFocusLiteApp());

    // Verify that our app loads with the welcome message.
    expect(find.text('Welcome to MindFocus Lite'), findsOneWidget);
    expect(find.text('Focus enhancement made simple'), findsOneWidget);

    // Verify bottom navigation bar is present.
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Stats'), findsOneWidget);
    expect(find.text('Suggestion'), findsOneWidget);
  });
}
