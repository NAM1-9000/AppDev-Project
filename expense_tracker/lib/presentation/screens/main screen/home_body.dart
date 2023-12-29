import 'package:expense_tracker/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:expense_tracker/presentation/widgets/entry_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccess) {
          return ListView.builder(
            itemCount: state.userModel.entries.length,
            itemBuilder: (context, index) {
              return EntryTile(
                title: state.userModel.entries[index].title,
                category: state.userModel.entries[index].category,
                amount: state.userModel.entries[index].amount,
                date: state.userModel.entries[index].date,
              );
            },
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
