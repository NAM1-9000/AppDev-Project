import 'package:expense_tracker/business%20logic/cubits/add_entry/add_entry_cubit.dart';
import 'package:expense_tracker/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:expense_tracker/data/models/entry_model.dart';
import 'package:expense_tracker/presentation/widgets/entry_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  late List<EntryModel> updatedUserEntres;

  final titleEditingController = TextEditingController();
  final categoryEditingController = TextEditingController();
  final amountEditingController = TextEditingController();

  void updateEntres(List<EntryModel> entries) {
    // setState(() {
    //   updatedUserEntres = entries;
    // });
  }

  void _openEntryDialog(String userEmail) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Edit Entry'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleEditingController,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    labelText: 'Title',
                  ),
                ),
                TextField(
                  controller: categoryEditingController,
                  decoration: const InputDecoration(
                    hintText: 'Category',
                    labelText: 'Category',
                  ),
                ),
                TextField(
                  controller: amountEditingController,
                  decoration: const InputDecoration(
                    hintText: 'Amount',
                    labelText: 'Amount',
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    BlocProvider.of<AddEntryCubit>(context).asyncDeleteEntry(
                      email: userEmail,
                      title: titleEditingController.text,
                    );

                    titleEditingController.clear();
                    categoryEditingController.clear();
                    amountEditingController.clear();

                    Navigator.of(context).pop();
                  },
                  child: const Text('Delete')),
              TextButton(
                onPressed: () {
                  BlocProvider.of<AddEntryCubit>(context).asyncEditEntry(
                    email: userEmail,
                    title: titleEditingController.text,
                    category: categoryEditingController.text,
                    amount: double.parse(amountEditingController.text),
                  );

                  Navigator.of(context).pop();

                  titleEditingController.clear();
                  categoryEditingController.clear();
                  amountEditingController.clear();
                },
                child: const Text('Confirm Changes'),
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    print("Init state called");
  }

  @override
  void dispose() {
    titleEditingController.dispose();
    categoryEditingController.dispose();
    amountEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Build called");
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccess) {
          String userEmail = state.userModel.email;
          List<EntryModel> entries = state.userModel.entries;

          return BlocConsumer<AddEntryCubit, AddEntryState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is AddEntrySuccess) {
                print(state);
                updatedUserEntres = state.userModel.entries;
                updateEntres(updatedUserEntres);
              }

              updatedUserEntres = entries;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: entries.length,
                  itemBuilder: (context, index) {
                    if (updatedUserEntres != null) {
                      return InkWell(
                        onTap: () {
                          _openEntryDialog(userEmail);
                        },
                        child: EntryTile(
                          title: updatedUserEntres[index].title,
                          category: updatedUserEntres[index].category,
                          amount: updatedUserEntres[index].amount,
                          date: updatedUserEntres[index].date,
                        ),
                      );
                    } else {
                      return EntryTile(
                        title: entries[index].title,
                        category: entries[index].category,
                        amount: entries[index].amount,
                        date: entries[index].date,
                      );
                    }
                  },
                ),
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
