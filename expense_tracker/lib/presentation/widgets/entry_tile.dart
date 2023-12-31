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
        title: Text(title),
        subtitle: Text('Category: $category'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Rs. $amount'),
            Text('${date.day}/${date.month}/${date.year}'),
          ],
        ),
      ),
    );
  }
}
