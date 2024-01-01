import 'package:expense_tracker/presentation/widgets/entry_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Entry Tile UI Test", () {
    testWidgets("Renders Entry Tile", (WidgetTester widgetTester) async {
      String title = "some title";
      String category = "some category";
      double amount = 63;
      DateTime date = DateTime.now();

      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EntryTile(
                title: title, category: category, amount: amount, date: date),
          ),
        ),
      );

      expect(find.text(title), findsOneWidget);
      expect(find.text(category), findsOneWidget);
    });
  });
}
