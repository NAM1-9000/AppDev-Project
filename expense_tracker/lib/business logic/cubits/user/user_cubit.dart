import 'package:bloc/bloc.dart';
import 'package:expense_tracker/business%20logic/cubits/user/user_state.dart';
import 'package:expense_tracker/data/models/user_model.dart';
import 'package:expense_tracker/data/network/user_network.dart';

class UserCubit extends Cubit<UserState> {
  final UserNetwork userFirestore;

  UserCubit(this.userFirestore) : super(UserInitial());

  Future<void> fetchUserData(String userId) async {
    emit(UserLoading());

    try {
      final user = await userFirestore.getUser(userId);
      emit(UserLoaded(user));
    } catch (e) {
      emit(UserError('Failed to fetch user data: $e'));
    }
  }

  Future<void> addUser(UserModel user) async {
    try {
      await userFirestore.addUser(user);
      emit(UserLoaded(user));
    } catch (e) {
      emit(UserError('Failed to add user: $e'));
    }
  }

  Future<void> updateUser(String userId, UserModel updatedUser) async {
    try {
      await userFirestore.updateUser(userId, updatedUser);
      emit(UserLoaded(updatedUser));
    } catch (e) {
      emit(UserError('Failed to update user: $e'));
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      await userFirestore.deleteUser(userId);
      emit(UserInitial());
    } catch (e) {
      emit(UserError('Failed to delete user: $e'));
    }
  }
}
