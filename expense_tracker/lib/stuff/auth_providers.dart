// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class FirebaseAuthService {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//   Future<User?> signUpWithEmailAndPassword(
//       String email, String password) async {
//     try {
//       UserCredential userCredential =
//           await _firebaseAuth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return userCredential.user;
//     } catch (e) {
//       print(e);
//       return null;
//     }
//   }

//   Future<User?> signInWithEmailAndPassword(
//       String email, String password) async {
//     try {
//       UserCredential userCredential =
//           await _firebaseAuth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return userCredential.user;
//     } catch (e) {
//       print(e);
//       return null;
//     }
//   }

//   Future<void> signOut() async {
//     await _firebaseAuth.signOut();
//   }

//   Future<User?> getCurrentUser() async {
//     return _firebaseAuth.currentUser;
//   }
// }

// final firebaseAuthServiceProvider = Provider<FirebaseAuthService>((ref) {
//   return FirebaseAuthService();
// });

// final authStateProvider = FutureProvider<User?>((ref) async {
//   final authService = ref.read(firebaseAuthServiceProvider);
//   return authService.getCurrentUser();
// });
