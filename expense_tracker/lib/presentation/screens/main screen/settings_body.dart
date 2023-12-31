import 'package:expense_tracker/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:expense_tracker/business%20logic/cubits/theme/theme_cubit.dart'; // Import ThemeCubit
import 'package:expense_tracker/business%20logic/cubits/theme/theme_state.dart';
import 'package:expense_tracker/utils/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsBody extends StatefulWidget {
  const SettingsBody({Key? key});

  @override
  State<SettingsBody> createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<SettingsBody> {
  TextEditingController _budgetController = TextEditingController();

  void showChangeBudgetDialogue() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Budget'),
          content: TextField(
            controller: _budgetController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Enter new budget',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Access the AuthCubit and update the user's monthly budget
                final authCubit = context.read<AuthCubit>();
                final newBudget =
                    double.tryParse(_budgetController.text) ?? 0.0;

                // Update the user's monthly budget attribute
                authCubit.updateUserMonthlyBudget(newBudget);

                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // Listener for AuthCubit
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthInitial) {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            }
          },
        ),
        // Listener for ThemeCubit
        BlocListener<ThemeCubit, ThemeState>(
          listener: (context, state) {
            if (state is ThemeChanged) {
              print('Theme changed');
            }
          },
        ),
      ],
      child: Center(
        child: Column(
          children: [
            const Divider(
              color: Colors.transparent,
            ),
            ListTile(
              title: const Text('Dark Mode'),
              subtitle: const Text('Enable dark mode'),
              trailing: Switch(
                value: context.select((ThemeCubit themeCubit) {
                  return themeCubit.state is ThemeChanged &&
                      (themeCubit.state as ThemeChanged).themeData ==
                          Pallete.darkModeAppTheme;
                }),
                onChanged: (value) {
                  context.read<ThemeCubit>().toggleTheme(value);
                },
              ),
              onTap: () {
                print('Dark Mode tapped');
              },
            ),
            const Divider(
              color: Colors.transparent,
            ),
            ListTile(
              title: const Text('Set Monthly Budget'),
              subtitle: const Text('Set your monthly budget'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                showChangeBudgetDialogue();
              },
            ),
            const Divider(
              color: Colors.transparent,
            ),
            // about list tile
            ListTile(
              title: const Text('About'),
              subtitle: const Text('Learn more about the app'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pushNamed(context, '/about');
              },
            ),
            const Divider(
              color: Colors.transparent,
            ),
            // logout list tile
            ListTile(
              title: const Text('Sign Out'),
              subtitle: const Text('Sign out of the app'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                // are you sure dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Are you sure?'),
                      content: const Text('Do you want to sign out?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('No'),
                        ),
                        TextButton(
                          onPressed: () {
                            context.read<AuthCubit>().emailPasswordSignOut();
                          },
                          child: const Text('Yes'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
