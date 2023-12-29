import 'package:expense_tracker/data/models/entry_model.dart';
import 'package:expense_tracker/data/network/entry_network.dart';

class EntryRepository {
  final EntryNetwork _entryNetwork = EntryNetwork();

  Future<List<EntryModel>> getEntries(String userId) async {
    return await _entryNetwork.getEntries(userId);
  }
}
