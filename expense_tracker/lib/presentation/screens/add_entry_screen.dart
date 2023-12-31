import 'package:expense_tracker/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:expense_tracker/business%20logic/cubits/entry/add_entry_cubit.dart';
import 'package:expense_tracker/presentation/widgets/form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEntryScreen extends StatefulWidget {
  const AddEntryScreen({super.key});

  @override
  State<AddEntryScreen> createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  // controllers
  TextEditingController titleController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  String _selectedCategory = "Grocery";

  @override
  Widget build(BuildContext context) {
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
                Container(
                  child: FormFieldWidget(
                    hintText: 'Title',
                    labelText: 'Title',
                    inputType: TextInputType.text,
                    controller: titleController,
                  ),
                ),

                // category
                // FormFieldWidget(
                //   hintText: 'Category',
                //   labelText: 'Category',
                //   inputType: TextInputType.text,
                //   controller: categoryController,
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    width: double.infinity,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        DropdownButtonFormField<String>(
                          isExpanded: true,
                          value: _selectedCategory,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 0),
                            labelText: 'Category',
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedCategory = newValue!;
                            });
                          },
                          items: <String>[
                            'Grocery',
                            'Transport',
                            'Bill',
                            'Subscription',
                            'Others'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),

                // amount
                FormFieldWidget(
                  hintText: 'Amount',
                  labelText: 'Amount',
                  inputType: TextInputType.number,
                  controller: amountController,
                ),
                SizedBox(height: 10),
                // add button
                ElevatedButton(
                  onPressed: () {
                    double amount = double.parse(amountController.text);
                    String title = titleController.text;
                    String category = _selectedCategory;

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
