import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:expense_tracker/models/entry_model.dart';

class UserModel {
  final String email;
  final String password;
  final double monthlyBudget;
  final double monthlySpending;
  final List<EntryModel> entries;
  UserModel({
    required this.email,
    required this.password,
    required this.monthlyBudget,
    required this.monthlySpending,
    required this.entries,
  });

  UserModel copyWith({
    String? email,
    String? password,
    double? monthlyBudget,
    double? monthlySpending,
    List<EntryModel>? entries,
  }) {
    return UserModel(
      email: email ?? this.email,
      password: password ?? this.password,
      monthlyBudget: monthlyBudget ?? this.monthlyBudget,
      monthlySpending: monthlySpending ?? this.monthlySpending,
      entries: entries ?? this.entries,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'monthlyBudget': monthlyBudget,
      'monthlySpending': monthlySpending,
      'entries': entries.map((x) => x.toMap()).toList(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] as String,
      password: map['password'] as String,
      monthlyBudget: map['monthlyBudget'] as double,
      monthlySpending: map['monthlySpending'] as double,
      entries: List<EntryModel>.from(
        (map['entries'] as List<EntryModel>).map<EntryModel>(
          (x) => EntryModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(email: $email, password: $password, monthlyBudget: $monthlyBudget, monthlySpending: $monthlySpending, entries: $entries)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.password == password &&
        other.monthlyBudget == monthlyBudget &&
        other.monthlySpending == monthlySpending &&
        listEquals(other.entries, entries);
  }

  @override
  int get hashCode {
    return email.hashCode ^
        password.hashCode ^
        monthlyBudget.hashCode ^
        monthlySpending.hashCode ^
        entries.hashCode;
  }
}
