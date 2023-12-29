import 'package:expense_tracker/data/models/entry_model.dart';
import 'package:expense_tracker/presentation/widgets/appbar.dart';
import 'package:expense_tracker/presentation/widgets/naviagtion_menu.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  @override
  Widget build(BuildContext context) {
    List<EntryModel> mockData = [
      EntryModel(
        title: 'Expense 1',
        amount: 50.0,
        date: DateTime.now().subtract(const Duration(days: 6)),
        category: 'Food',
        notes: 'Lunch',
      ),
      EntryModel(
        title: 'Expense 2',
        amount: 80.0,
        date: DateTime.now().subtract(const Duration(days: 5)),
        category: 'Shopping',
        notes: 'Clothes',
      ),
      EntryModel(
        title: 'Expense 3',
        amount: 30.0,
        date: DateTime.now().subtract(const Duration(days: 4)),
        category: 'Transportation',
        notes: 'Uber',
      ),
    ];

    return Scaffold(
      appBar: buildAppBar(
        DateFormat('EEEE, d MMMM').format(DateTime.now()),
        '42000',
        '69420',
      ),
      body: const Center(child: Text('Analytics')),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
