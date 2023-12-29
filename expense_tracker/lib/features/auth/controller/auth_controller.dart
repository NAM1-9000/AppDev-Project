import 'package:expense_tracker/core/utils.dart';
import 'package:expense_tracker/features/auth/repository/auth_repository.dart';
import 'package:expense_tracker/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    authRepository: ref.watch(authRepositoryProvider),
    ref: ref,
  ),
);

final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChanges;
});

final getUserProvider = StreamProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;
  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref,
        super(false);

  Stream<User?> get authStateChanges => _authRepository.authStateChanges;

  void signInWithGoogle(BuildContext context) async {
    state = true;
    final user = await _authRepository.signInWithGoogle();
    state = false;
    user.fold(
      (l) => showSnackBar(context, l.message),
      (userModel) {
        _ref.read(userProvider.notifier).update((state) => userModel);
        navigateToHome(context);
      },
    );
  }

  Stream<UserModel> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }

  //fr

  void signUpWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    state = true;
    final user =
        await _authRepository.signUpWithEmailAndPassword(email, password);
    state = false;
    user.fold(
      (l) => {
        state = false,
        showSnackBar(context, l.message),
      },
      (userModel) {
        _ref.read(userProvider.notifier).update((state) => userModel);
        navigateToHome(context);
      },
    );
  }

  void signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    state = true;
    final user =
        await _authRepository.signInWithEmailAndPassword(email, password);
    state = false;
    user.fold(
      (l) => showSnackBar(context, l.message),
      (userModel) {
        _ref.read(userProvider.notifier).update((state) => userModel);
        navigateToHome(context);
      },
    );
  }

  void navigateToHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/home');
  }
}
