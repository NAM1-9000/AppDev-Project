import 'package:expense_tracker/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:expense_tracker/presentation/screens/main%20screen/analytics_body.dart';
import 'package:expense_tracker/presentation/screens/main%20screen/home_body.dart';
import 'package:expense_tracker/presentation/screens/main%20screen/settings_body.dart';
import 'package:expense_tracker/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    // date
    DateTime today = DateTime.now();
    String formattedDate = DateFormat('EEEE, MMMM d').format(today);

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.amber,
        title: Text(formattedDate, style: const TextStyle(fontSize: 25)),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                //color: const Color.fromARGB(255, 48, 48, 48),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 180,
                      height: 120,
                      child: Card(
                        color: Colors.greenAccent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Spending',
                                    style: const TextStyle(fontSize: 18)),
                                SizedBox(height: 10),
                                // monthly spending
                                BlocBuilder<AuthCubit, AuthState>(
                                  builder: (context, state) {
                                    if (state is AuthSuccess) {
                                      return Text(
                                        "Rs.${state.userModel.monthlySpending.toString()}",
                                        style: const TextStyle(
                                          fontSize: 24,
                                        ),
                                      );
                                    } else {
                                      return const Text(
                                        'Loading...',
                                        style: TextStyle(fontSize: 20),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 180,
                      height: 120,
                      child: Card(
                        color: Colors.redAccent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Budget',
                                    style: const TextStyle(fontSize: 18)),
                                SizedBox(height: 10),
                                BlocBuilder<AuthCubit, AuthState>(
                                  builder: (context, state) {
                                    if (state is AuthSuccess) {
                                      return Text(
                                        "Rs.${state.userModel.monthlyBudget.toString()}",
                                        style: const TextStyle(
                                          fontSize: 24,
                                        ),
                                      );
                                    } else {
                                      return const Text(
                                        'Loading...',
                                        style: TextStyle(fontSize: 20),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),

              // child: Column(
              //   children: [
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text('Monthly Budget',
              //             style: const TextStyle(fontSize: 20)),
              //         BlocBuilder<AuthCubit, AuthState>(
              //           builder: (context, state) {
              //             if (state is AuthSuccess) {
              //               return Text(
              //                 "Rs. ${state.userModel.monthlyBudget.toString()}",
              //                 style: const TextStyle(fontSize: 20),
              //               );
              //             } else {
              //               return const Text(
              //                 'Loading...',
              //                 style: TextStyle(fontSize: 20),
              //               );
              //             }
              //           },
              //         ),
              //       ],
              //     ),
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text('Monthly Spending',
              //             style: const TextStyle(fontSize: 20)),
              //         // monthly spending
              //         BlocBuilder<AuthCubit, AuthState>(
              //           builder: (context, state) {
              //             if (state is AuthSuccess) {
              //               return Text(
              //                 "Rs. ${state.userModel.monthlySpending.toString()}",
              //                 style: const TextStyle(fontSize: 20),
              //               );
              //             } else {
              //               return const Text(
              //                 'Loading...',
              //                 style: TextStyle(fontSize: 20),
              //               );
              //             }
              //           },
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
            ),
          ),
        ),
      ),

      // body
      body: IndexedStack(
        index: _currentIndex,
        children: const <Widget>[
          AnalyticsBody(),
          HomeBody(),
          SettingsBody(),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Pallete.blueColor,
        child: const Icon(Icons.add, color: Colors.white, size: 30),
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/add_entry');
        },
      ),

      // bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_graph),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
