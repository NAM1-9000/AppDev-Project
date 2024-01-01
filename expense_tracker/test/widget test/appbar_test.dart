import 'package:expense_tracker/presentation/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("App Baraa UI Test", () {
    testWidgets("Renders App Bar", (WidgetTester widgetTester) async {
      String title = "some title";
      String text1 = "some text1";
      String text2 = "some text2";

      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: buildAppBar(title, text1, text2),
          ),
        ),
      );

      expect(find.text(title), findsOneWidget);
      expect(find.text(text1), findsOneWidget);
      expect(find.text(text2), findsOneWidget);
    });
  });
}
