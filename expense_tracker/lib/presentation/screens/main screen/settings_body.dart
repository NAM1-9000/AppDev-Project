import 'package:expense_tracker/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    // about
    // logout
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial) {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, '/login');
        }
      },
      child: Center(
        child: Column(
          children: [
            Divider(),
            ListTile(
              title: const Text('Set Monthly Budget'),
              subtitle: const Text('Set your monthly budget'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {},
            ),
            Divider(),
            // about list tile
            ListTile(
              title: const Text('About'),
              subtitle: const Text('Learn more about the app'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pushNamed(context, '/about');
              },
            ),
            Divider(),
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
