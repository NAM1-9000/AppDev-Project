import 'package:expense_tracker/data/models/user_model.dart';
import 'package:expense_tracker/data/network/auth_network.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final AuthNetwork _authNetwork = AuthNetwork();

  Future<UserModel> emailPasswordSignUp(String email, String password) async {
    try {
      return await _authNetwork.emailPasswordSignUp(email, password);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<UserModel> emailPasswordSignIn(String email, String password) async {
    try {
      return await _authNetwork.emailPasswordSignIn(email, password);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> emailPasswordSignOut() async {
    try {
      await _authNetwork.emailPasswordSignOut();
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }
}
