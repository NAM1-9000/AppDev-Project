import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/data/models/entry_model.dart';
import 'package:expense_tracker/data/models/user_model.dart';

class EntryNetwork {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel?> addEntry(
      String userEmail, String title, String category, double amount) async {
    try {
      EntryModel entryModel = EntryModel(
        title: title,
        category: category,
        amount: amount,
        date: DateTime.now(),
      );

      DocumentSnapshot userSnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: userEmail)
          .limit(1)
          .get()
          .then((querySnapshot) => querySnapshot.docs.first);

      if (userSnapshot.exists) {
        UserModel user =
            UserModel.fromMap(userSnapshot.data() as Map<String, dynamic>);

        List<EntryModel> userEntres = user.entries;

        userEntres.add(entryModel);

        user = user.copyWith(entries: userEntres);

        QuerySnapshot querySnapshot = await _firestore
            .collection('users')
            .where('email', isEqualTo: userEmail)
            .limit(1)
            .get();

        String userId = querySnapshot.docs.first.id;
        await _firestore.collection('users').doc(userId).update(user.toMap());

        return user;
      }
      return null;
    } catch (e) {}
  }

  Future<UserModel?> editEntry(
      String userEmail, String title, String category, double amount) async {
    try {
      // create a new entry with the updated values
      EntryModel updatedEntry = EntryModel(
        title: title,
        category: category,
        amount: amount,
        date: DateTime.now(),
      );

      DocumentSnapshot userSnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: userEmail)
          .limit(1)
          .get()
          .then((querySnapshot) => querySnapshot.docs.first);

      if (userSnapshot.exists) {
        UserModel user =
            UserModel.fromMap(userSnapshot.data() as Map<String, dynamic>);

        // find the entry with the specified title and update it
        List<EntryModel> userEntries = user.entries;

        print(userEntries);

        int indexOfEntry =
            userEntries.indexWhere((entry) => entry.title == title);

        if (indexOfEntry != -1) {
          userEntries[indexOfEntry] = updatedEntry;
        } else {
          // error ithay
        }

        user = user.copyWith(entries: userEntries);

        // update the user document in Firestore
        await _firestore
            .collection('users')
            .doc(userSnapshot.id)
            .update(user.toMap());

        return user;
      }
      return null;
    } catch (e) {
      // Handle exceptions appropriately
      print(e.toString());
      return null;
    }
  }

  Future<UserModel?> deleteEntry(String userEmail, String title) async {
    try {
      DocumentSnapshot userSnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: userEmail)
          .limit(1)
          .get()
          .then((querySnapshot) => querySnapshot.docs.first);

      if (userSnapshot.exists) {
        UserModel user =
            UserModel.fromMap(userSnapshot.data() as Map<String, dynamic>);

        // Find the entry with the specified title and remove it
        List<EntryModel> userEntries = user.entries;
        userEntries.removeWhere((entry) => entry.title == title);

        user = user.copyWith(entries: userEntries);

        // Update the user document in Firestore
        await _firestore
            .collection('users')
            .doc(userSnapshot.id)
            .update(user.toMap());

        return user;
      }
      return null;
    } catch (e) {
      // Handle exceptions appropriately
      print(e.toString());
      return null;
    }
  }
}
