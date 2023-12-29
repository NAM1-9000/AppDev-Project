import 'package:expense_tracker/data/models/entry_model.dart';
import 'package:expense_tracker/presentation/widgets/appbar.dart';
import 'package:expense_tracker/presentation/widgets/form_field.dart';
import 'package:expense_tracker/presentation/widgets/naviagtion_menu.dart';
import 'package:expense_tracker/stuff/database_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _databaseService = DatabaseService();
  String _selectedCategory = "Grocery";
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: buildAppBar(
          DateFormat('EEEE, d MMMM').format(DateTime.now()), '42000', '69420'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Recent Expenses"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Upcoming Payments"),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.68,
              width: MediaQuery.sizeOf(context).width,
              child: StreamBuilder(
                  stream: _databaseService.getEntries(),
                  builder: (context, snapshot) {
                    List entries = snapshot.data?.docs ?? [];
                    entries.sort((a, b) => b['date'].compareTo(a['date']));
                    if (entries.isEmpty) {
                      return const Center(child: Text("No entries yet"));
                    }
                    return ListView.builder(
                        itemCount: entries.length,
                        itemBuilder: (context, index) {
                          EntryModel entry = entries[index].data();
                          String entryid = entries[index].id;
                          return ListTile(
                            onTap: () {
                              _titleController.text = entry.title;
                              _amountController.text = entry.amount.toString();
                              _notesController.text = entry.notes;
                              _selectedCategory = entry.category;
                              showEntryModalBottomSheet(
                                  context,
                                  _titleController,
                                  _amountController,
                                  _notesController,
                                  _selectedCategory,
                                  entry,
                                  entryid);
                            },
                            title: Text(entry.title),
                            subtitle: Text(entry.category),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Rs.${entry.amount.toString()}'),
                                Text(DateFormat.yMMMd()
                                    .add_Hm()
                                    .format(entry.date)),
                              ],
                            ),
                          );
                        });
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 50.0,
        width: 50.0,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/add_entry');
            },
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: const Icon(Icons.add, size: 35),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: const BottomNavigation(),
    );
  }

  void showEntryModalBottomSheet(
      BuildContext context,
      TextEditingController titleController,
      TextEditingController amountController,
      TextEditingController notesController,
      String selectedCategory,
      EntryModel entry,
      String entryid) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FormFieldWidget(
                  controller: titleController,
                  hintText: 'Title',
                  labelText: 'Title',
                  inputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 10,
                ),
                FormFieldWidget(
                  controller: amountController,
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
                    value: selectedCategory,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 0),
                      labelText: 'Category',
                      labelStyle: TextStyle(
                          color: Color.fromARGB(255, 80, 80, 80), fontSize: 20),
                    ),
                    style: const TextStyle(color: Colors.black),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCategory = newValue!;
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
                  controller: notesController,
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
                        onPressed: () => {
                              _databaseService.deleteEntry(entryid),
                              Navigator.pushReplacementNamed(context, '/home')
                            },
                        child: const Text("Delete")),
                    ElevatedButton(
                        onPressed: () {
                          EntryModel updatedEntry = entry.copyWith(
                              title: titleController.text,
                              amount: double.parse(amountController.text),
                              category: selectedCategory,
                              notes: notesController.text);
                          _databaseService.updateEntry(entryid, updatedEntry);
                        },
                        child: const Text("Update"))
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
