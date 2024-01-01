import 'package:expense_tracker/presentation/widgets/naviagtion_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Bottom Navigation UI Test", () {
    testWidgets("Renders Bottom Navigation", (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: BottomNavigation()),
        ),
      );

      expect(find.text("Analytics"), findsOneWidget);
      expect(find.text("Home"), findsOneWidget);
      expect(find.text("Settings"), findsOneWidget);
    });
  });
}
