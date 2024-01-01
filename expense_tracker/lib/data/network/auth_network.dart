import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthNetwork {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> emailPasswordSignUp(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      UserModel userModel = UserModel(
        email: email,
        password: password,
        monthlyBudget: 0,
        monthlySpending: 0,
        entries: [],
      );

      await _firestore.collection('users').doc(userCredential.user?.uid).set(
            userModel.toMap(),
          );

      return userModel;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<UserModel> emailPasswordSignIn(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user?.uid)
          .get();

      if (userDoc.exists) {
        final UserModel user =
            UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
        return user;
      } else {
        throw Exception('User does not exist');
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> emailPasswordSignOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  //bruh
  Future<void> updateMonthlyBudget(String userId, double newBudget) async {
    await _firestore.collection('users').doc(userId).update(
      {'monthlyBudget': newBudget},
    );
  }
}
