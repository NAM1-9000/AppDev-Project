// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:expense_tracker/data/models/entry_model.dart';
// import 'package:expense_tracker/data/models/user_model.dart';

// const String USER_COLLECTION_REF = 'users';
// const String ENTRY_COLLECTION_REF = 'entries';

// class DatabaseService {
//   final _firestore = FirebaseFirestore.instance;

//   late final CollectionReference _userRef;
//   late final CollectionReference _entryRef;

//   DatabaseService() {
//     _userRef = _firestore
//         .collection(USER_COLLECTION_REF)
//         .withConverter<UserModel>(
//             fromFirestore: (snapshots, _) =>
//                 UserModel.fromMap(snapshots.data()!),
//             toFirestore: (user, _) => user.toMap());

//     _entryRef = _firestore
//         .collection(ENTRY_COLLECTION_REF)
//         .withConverter<EntryModel>(
//             fromFirestore: (snapshots, _) =>
//                 EntryModel.fromMap(snapshots.data()!),
//             toFirestore: (entry, _) => entry.toMap());
//   }

//   Stream<QuerySnapshot> getUsers() {
//     return _userRef.snapshots();
//   }

//   void addUser(UserModel user) {
//     _userRef.add(user);
//   }

//   void updateUser(String userid, UserModel user) {
//     _userRef.doc(userid).update(user.toMap());
//   }

//   Stream<QuerySnapshot> getEntries() {
//     return _entryRef.snapshots();
//   }

//   void addEntry(EntryModel entry) {
//     _entryRef.add(entry);
//   }

//   void updateEntry(String entryid, EntryModel entry) {
//     _entryRef.doc(entryid).update(entry.toMap());
//   }

//   void deleteEntry(String entryid) {
//     _entryRef.doc(entryid).delete();
//   }
// }
