import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_tracker/data/models/entry_model.dart';
import 'package:expense_tracker/data/models/user_model.dart';
import 'package:expense_tracker/data/repositories/entry_repository.dart';

part 'add_entry_state.dart';

class AddEntryCubit extends Cubit<AddEntryState> {
  AddEntryCubit() : super(AddEntryInitial());

  final EntryRepository _entryRepository = EntryRepository();

  Future<void> asyncGetEntries({required String userEmail}) async {
    emit(AddEntryLoading());

    try {
      List<EntryModel> userEntries =
          await _entryRepository.getEntries(userEmail);
      emit(AddEntriesLoaded(userEntries: userEntries));
    } catch (error) {
      emit(AddEntryFailed(message: error.toString()));
    }
  }

  void asyncaddEntry({
    required String email,
    required String title,
    required String category,
    required double amount,
  }) async {
    emit(AddEntryLoading());

    try {
      UserModel? updatedUser =
          await _entryRepository.addEntry(email, title, category, amount);
      emit(AddEntrySuccess(userModel: updatedUser!));
    } catch (e) {
      emit(AddEntryFailed(message: e.toString()));
    }
  }

  void asyncEditEntry({
    required String email,
    required String title,
    required String category,
    required double amount,
  }) async {
    emit(AddEntryLoading());

    try {
      UserModel? updatedUser =
          await _entryRepository.editEntry(email, title, category, amount);
      emit(AddEntrySuccess(userModel: updatedUser!));
    } catch (e) {
      emit(AddEntryFailed(message: e.toString()));
    }
  }

  void asyncDeleteEntry({required String email, required String title}) async {
    emit(AddEntryLoading());

    try {
      UserModel? updatedUser = await _entryRepository.deleteEntry(email, title);
      emit(AddEntrySuccess(userModel: updatedUser!));
    } catch (e) {
      emit(AddEntryFailed(message: e.toString()));
    }
  }
}
