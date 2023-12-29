import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/data/models/entry_model.dart';
import 'package:expense_tracker/data/models/user_model.dart';

class EntryNetwork {
  Future<List<EntryModel>> getEntries(String userId) async {
    try {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        final UserModel user =
            UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
        return user.entries;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<void> addEntry(String userId, EntryModel entry) async {
    try {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        final UserModel user =
            UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
        user.entries.add(entry);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update(user.toMap());
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteEntry(String userId, EntryModel entry) async {
    try {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        final UserModel user =
            UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
        user.entries.remove(entry);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update(user.toMap());
      }
    } catch (e) {
      rethrow;
    }
  }
}
