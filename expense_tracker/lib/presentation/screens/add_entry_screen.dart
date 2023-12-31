import 'package:expense_tracker/business%20logic/cubits/add_entry/add_entry_cubit.dart';
import 'package:expense_tracker/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:expense_tracker/data/repositories/entry_repository.dart';
import 'package:expense_tracker/presentation/widgets/form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEntryScreen extends StatelessWidget {
  const AddEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // controllers
    TextEditingController titleController = TextEditingController();
    TextEditingController categoryController = TextEditingController();
    TextEditingController amountController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/main');
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Add Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            print(amountController.text);

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // title
                FormFieldWidget(
                  hintText: 'Title',
                  labelText: 'Title',
                  inputType: TextInputType.text,
                  controller: titleController,
                ),
                Divider(),
                // category
                FormFieldWidget(
                  hintText: 'Category',
                  labelText: 'Category',
                  inputType: TextInputType.text,
                  controller: categoryController,
                ),
                Divider(),
                // amount
                FormFieldWidget(
                  hintText: 'Amount',
                  labelText: 'Amount',
                  inputType: TextInputType.number,
                  controller: amountController,
                ),
                Divider(),
                // add button
                ElevatedButton(
                  onPressed: () {
                    double amount = double.parse(amountController.text);
                    String title = titleController.text;
                    String category = categoryController.text;

                    amountController.clear();
                    categoryController.clear();
                    titleController.clear();

                    context.read<AddEntryCubit>().asyncaddEntry(
                          email: (state as AuthSuccess).userModel.email,
                          title: title,
                          category: category,
                          amount: amount,
                        );

                    // EntryRepository().addEntry(
                    //   (state as AuthSuccess).userModel.email,
                    //   title,
                    //   category,
                    //   amount,
                    // );
                    Navigator.pushReplacementNamed(context, '/main');
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
