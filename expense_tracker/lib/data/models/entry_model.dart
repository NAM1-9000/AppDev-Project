import 'dart:convert';

class EntryModel {
  String title;
  double amount;
  DateTime date;
  String category;

  EntryModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });

  EntryModel copyWith({
    String? title,
    double? amount,
    DateTime? date,
    String? category,
  }) {
    return EntryModel(
      title: title ?? this.title,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'amount': amount,
      'date': date.millisecondsSinceEpoch,
      'category': category,
    };
  }

  factory EntryModel.fromMap(Map<String, dynamic> map) {
    return EntryModel(
      title: map['title'] as String,
      amount: (map['amount'] as num).toDouble(),
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      category: map['category'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EntryModel.fromJson(String source) =>
      EntryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EntryModel(title: $title, amount: $amount, date: $date, category: $category)';
  }

  @override
  bool operator ==(covariant EntryModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.amount == amount &&
        other.date == date &&
        other.category == category;
  }

  @override
  int get hashCode {
    return title.hashCode ^ amount.hashCode ^ date.hashCode ^ category.hashCode;
  }
}
