import 'package:expense_tracker/data/models/entry_model.dart';
import 'package:expense_tracker/data/models/user_model.dart';
import 'package:expense_tracker/data/network/entry_network.dart';

class EntryRepository {
  final EntryNetwork _entryNetwork = EntryNetwork();

  Future<List<EntryModel>> getEntries(String userEmail) async {
    return await _entryNetwork.getEntries(userEmail);
  }

  Future<UserModel?> addEntry(
      String email, String title, String category, double amount) async {
    return await _entryNetwork.addEntry(email, title, category, amount);
  }

  Future<UserModel?> editEntry(
      String userEmail, String title, String category, double amount) async {
    return await _entryNetwork.editEntry(userEmail, title, category, amount);
  }

  Future<UserModel?> deleteEntry(String userEmail, String title) async {
    return await _entryNetwork.deleteEntry(userEmail, title);
  }
}
