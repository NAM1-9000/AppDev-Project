import 'package:expense_tracker/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:expense_tracker/business%20logic/cubits/entry/add_entry_cubit.dart';
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

  void _openEntryDialog(
      String userEmail,
      TextEditingController titleController,
      TextEditingController categoryController,
      TextEditingController amountController) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Edit Entry'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    labelText: 'Title',
                  ),
                ),
                TextField(
                  controller: categoryController,
                  decoration: const InputDecoration(
                    hintText: 'Category',
                    labelText: 'Category',
                  ),
                ),
                TextField(
                  controller: amountController,
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

  void fetchEntries(String userEmail) {
    BlocProvider.of<AddEntryCubit>(context)
        .asyncGetEntries(userEmail: userEmail);
  }

  @override
  void initState() {
    super.initState();
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

          return BlocConsumer<AddEntryCubit, AddEntryState>(
            listener: (context, state) {
              if (state is AddEntriesLoaded) {
                updatedUserEntres = state.userEntries;
              }
            },
            builder: (context, state) {
              // fetch user's entries
              if (state is AddEntryInitial) {
                fetchEntries(userEmail);
              }

              if (state is AddEntrySuccess) {
                fetchEntries(userEmail);
              }

              if (state is AddEntryLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is AddEntriesLoaded) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: state.userEntries.length,
                    itemBuilder: (context, index) {
                      EntryModel userEntry = state.userEntries[index];

                      return InkWell(
                        onTap: () {
                          titleEditingController.text = userEntry.title;
                          categoryEditingController.text = userEntry.category;
                          amountEditingController.text =
                              userEntry.amount.toString();
                          _openEntryDialog(
                              userEmail,
                              titleEditingController,
                              categoryEditingController,
                              amountEditingController);
                        },
                        child: EntryTile(
                          title: userEntry.title,
                          category: userEntry.category,
                          amount: userEntry.amount,
                          date: userEntry.date,
                        ),
                      );
                    },
                  ),
                );
              }

              return const SizedBox();
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}
