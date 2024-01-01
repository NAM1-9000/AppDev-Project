import 'package:expense_tracker/presentation/widgets/form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Form Field Widget UI Test", () {
    testWidgets("Renders Form Field Widget", (WidgetTester widgetTester) async {
      String hintText = "some hint text";

      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FormFieldWidget(
              hintText: hintText,
            ),
          ),
        ),
      );

      expect(find.text(hintText), findsOneWidget);
    });
  });
}
