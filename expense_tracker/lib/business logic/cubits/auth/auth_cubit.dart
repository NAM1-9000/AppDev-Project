import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_tracker/data/models/user_model.dart';
import 'package:expense_tracker/data/network/auth_network.dart';
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

  //bruh
  Future<void> updateUserMonthlyBudget(double newBudget) async {
    try {
      final userModel = (state as AuthSuccess).userModel;
      final userId =
          userModel.email; // Assuming you have an 'id' field in your UserModel
      final authNetwork = AuthNetwork();

      await authNetwork.updateMonthlyBudget(userId, newBudget);

      // Use copyWith to update the local UserModel with the new budget
      final updatedUserModel = userModel.copyWith(monthlyBudget: newBudget);

      // Emit a new AuthSuccess state with the updated UserModel
      emit(AuthSuccess(updatedUserModel));
    } on Exception catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }
}
