import 'package:flutter/material.dart';

class EntryTile extends StatelessWidget {
  const EntryTile({
    super.key,
    required this.title,
    required this.category,
    required this.amount,
    required this.date,
  });

  final String title;
  final String category;
  final double amount;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title, style: const TextStyle(fontSize: 18)),
        subtitle: Text('$category',
            style: const TextStyle(
              fontSize: 11,
              fontFamily: 'Roboto',
            )),
        trailing: Text('Rs.$amount',
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }
}
