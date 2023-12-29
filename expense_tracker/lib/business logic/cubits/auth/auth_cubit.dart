import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_tracker/data/models/user_model.dart';
import 'package:expense_tracker/data/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final AuthRepository _authRepository = AuthRepository();

  // sign up
  Future<void> emailPasswordSignUp(String email, String password) async {
    try {
      emit(AuthLoading());
      final UserModel userModel =
          await _authRepository.emailPasswordSignUp(email, password);
      emit(AuthSuccess(userModel));
    } on Exception catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  // sign in
  Future<void> emailPasswordSignIn(String email, String password) async {
    try {
      emit(AuthLoading());
      final UserModel userModel =
          await _authRepository.emailPasswordSignIn(email, password);
      emit(AuthSuccess(userModel));
    } on Exception catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  // sign out
  Future<void> emailPasswordSignOut() async {
    try {
      emit(AuthLoading());
      await _authRepository.emailPasswordSignOut();
      emit(AuthInitial());
    } on Exception catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }
}
