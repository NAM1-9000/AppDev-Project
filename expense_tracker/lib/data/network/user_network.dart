import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/data/models/entry_model.dart';
import 'package:expense_tracker/data/models/user_model.dart';

class UserNetwork {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> addUser(UserModel user) async {
    await usersCollection.add({
      'email': user.email,
      'password': user.password,
      'monthlyBudget': user.monthlyBudget,
      'monthlySpending': user.monthlySpending,
      'entries': user.entries.map((entry) => entry.toJson()).toList(),
    });
  }

  Future<UserModel> getUser(String userId) async {
    DocumentSnapshot documentSnapshot = await usersCollection.doc(userId).get();

    return UserModel(
      email: documentSnapshot['email'],
      password: documentSnapshot['password'],
      monthlyBudget: documentSnapshot['monthlyBudget'],
      monthlySpending: documentSnapshot['monthlySpending'],
      entries: (documentSnapshot['entries'] as List<dynamic>)
          .map((entryData) => EntryModel.fromJson(entryData))
          .toList(),
    );
  }

  Future<void> updateUser(String userId, UserModel updatedUser) async {
    await usersCollection.doc(userId).update({
      'email': updatedUser.email,
      'password': updatedUser.password,
      'monthlyBudget': updatedUser.monthlyBudget,
      'monthlySpending': updatedUser.monthlySpending,
      'entries': updatedUser.entries.map((entry) => entry.toJson()).toList(),
    });
  }

  Future<void> deleteUser(String userId) async {
    await usersCollection.doc(userId).delete();
  }
}
