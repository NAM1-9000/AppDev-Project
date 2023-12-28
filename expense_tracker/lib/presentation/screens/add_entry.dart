import 'package:expense_tracker/models/entry_model.dart';
import 'package:expense_tracker/presentation/widgets/form_field.dart';
import 'package:expense_tracker/providers/database_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  String _selectedCategory = "Grocery";
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          title: Text(DateFormat('EEEE, d MMMM').format(DateTime.now())),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(150),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "42000",
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                Text("69420",
                    style: TextStyle(fontSize: 30, color: Colors.white)),
              ],
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              FormFieldWidget(
                controller: _titleController,
                hintText: 'Title',
                labelText: 'Title',
                inputType: TextInputType.text,
              ),
              const SizedBox(
                height: 10,
              ),
              FormFieldWidget(
                controller: _amountController,
                hintText: 'Amount',
                labelText: 'Amount',
                inputType: TextInputType.number,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.35),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  value: _selectedCategory,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 0),
                    labelText: 'Category',
                    labelStyle: TextStyle(
                        color: Color.fromARGB(255, 80, 80, 80), fontSize: 20),
                  ),
                  style: const TextStyle(color: Colors.black),
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
              ),
              const SizedBox(
                height: 10,
              ),
              FormFieldWidget(
                controller: _notesController,
                numberOfLines: 4,
                hintText: 'Notes',
                labelText: 'Notes',
                inputType: TextInputType.multiline,
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, '/home'),
                      child: const Text("Cancel")),
                  ElevatedButton(
                      onPressed: () => {
                            _databaseService.addEntry(EntryModel(
                                date: DateTime.now(),
                                title: _titleController.text,
                                amount: double.parse(_amountController.text),
                                category: _selectedCategory,
                                notes: _notesController.text)),
                            Navigator.pushNamed(context, '/home')
                          },
                      child: const Text("Confirm"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
