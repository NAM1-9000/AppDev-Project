import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class EntryModel {
  String title;
  double amount;
  DateTime date;
  String category;
  String notes;
  EntryModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    required this.notes,
  });

  EntryModel copyWith({
    String? title,
    double? amount,
    DateTime? date,
    String? category,
    String? notes,
  }) {
    return EntryModel(
      title: title ?? this.title,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      category: category ?? this.category,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'amount': amount,
      'date': Timestamp.fromDate(date),
      'category': category,
      'notes': notes,
    };
  }

  factory EntryModel.fromMap(Map<String, dynamic> map) {
    return EntryModel(
      title: map['title'] as String,
      amount: (map['amount'] as num).toDouble(),
      date: (map['date'] as Timestamp).toDate(),
      category: map['category'] as String,
      notes: map['notes'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EntryModel.fromJson(String source) =>
      EntryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EntryModel(title: $title, amount: $amount, date: $date, category: $category, notes: $notes)';
  }

  @override
  bool operator ==(covariant EntryModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.amount == amount &&
        other.date == date &&
        other.category == category &&
        other.notes == notes;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        amount.hashCode ^
        date.hashCode ^
        category.hashCode ^
        notes.hashCode;
  }
}
