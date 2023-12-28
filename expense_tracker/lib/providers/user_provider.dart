// user_provider.dart

import 'package:expense_tracker/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userModelProvider = ChangeNotifierProvider.autoDispose<UserModel>((ref) {
  return UserModel(
    email: '',
    password: '',
    monthlyBudget: 0.0,
    monthlySpending: 0.0,
    entries: [],
  );
});
