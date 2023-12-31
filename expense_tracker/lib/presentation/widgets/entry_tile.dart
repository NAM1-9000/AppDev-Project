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

//dictionary to map category to icon
  static const Map<String, IconData> categoryIcons = {
    'Grocery': Icons.shopping_cart,
    'Transport': Icons.directions_car,
    'Bill': Icons.receipt,
    'Subscription': Icons.subscriptions,
    'Others': Icons.category,
  };

  @override
  Widget build(BuildContext context) {
    IconData iconData = categoryIcons[category] ?? Icons.category;
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Icon(
            iconData,
            color: Colors.white,
          ),
        ),
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
