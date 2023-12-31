import 'package:expense_tracker/presentation/widgets/appbar.dart';
import 'package:expense_tracker/presentation/widgets/naviagtion_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
          DateFormat('EEEE, d MMMM').format(DateTime.now()), '42000', '69420'),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Notification Settings'),
            subtitle: const Text('Manage notification preferences'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              print('Notification Settings tapped');
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Account Settings'),
            subtitle: const Text('Manage your account details'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              print('Account Settings tapped');
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Appearance'),
            subtitle: const Text('Customize the app theme'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              print('Appearance tapped');
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Privacy'),
            subtitle: const Text('Manage privacy settings'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              print('Privacy tapped');
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('About'),
            subtitle: const Text('Learn more about the app'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushNamed(context, '/about');
              print('About tapped');
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Sign Out'),
            subtitle: const Text('Sign out of the app'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/login');
              print('Sign Out tapped');
            },
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
