import 'package:expense_tracker/presentation/widgets/auth_screens_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Auth Screen Button UI Test", () {
    testWidgets("Renders Auth Screen Button",
        (WidgetTester widgetTester) async {
      String buttonLabel = "some label";
      onPressed() {}

      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AuthScreensButton(
                buttonLabel: buttonLabel, onPressed: onPressed),
          ),
        ),
      );

      expect(find.text(buttonLabel), findsOneWidget);
    });
  });
}
