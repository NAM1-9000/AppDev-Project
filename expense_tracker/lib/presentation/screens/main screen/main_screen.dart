import 'package:expense_tracker/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:expense_tracker/presentation/screens/main%20screen/analytics_body.dart';
import 'package:expense_tracker/presentation/screens/main%20screen/home_body.dart';
import 'package:expense_tracker/presentation/screens/main%20screen/settings_body.dart';
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
        backgroundColor: Colors.yellow,
        title: Text(formattedDate),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // monthly spending
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is AuthSuccess) {
                    return Text(
                      "Rs. ${state.userModel.monthlySpending.toString()}",
                      style: const TextStyle(fontSize: 24),
                    );
                  } else {
                    return const Text(
                      'Loading...',
                      style: TextStyle(fontSize: 24),
                    );
                  }
                },
              ),

              // monthly budget
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is AuthSuccess) {
                    return Text(
                      "Rs. ${state.userModel.monthlyBudget.toString()}",
                      style: const TextStyle(fontSize: 24),
                    );
                  } else {
                    return const Text(
                      'Loading...',
                      style: TextStyle(fontSize: 24),
                    );
                  }
                },
              ),
            ],
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
        child: const Icon(Icons.add),
        onPressed: () {},
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
            icon: Icon(Icons.analytics),
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
