import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/features/auth/screens/login_screen.dart';
import 'package:expense_tracker/features/auth/screens/signup_screen.dart';
import 'package:expense_tracker/firebase_options.dart';
import 'package:expense_tracker/features/settings/screens/about.dart';
import 'package:expense_tracker/splash__screen.dart';
import 'package:expense_tracker/presentation/screens/add_entry.dart';
import 'package:expense_tracker/presentation/screens/analytics.dart';
import 'package:expense_tracker/presentation/screens/home.dart';
import 'package:expense_tracker/features/settings/screens/settings.dart';
import 'package:expense_tracker/theme/pallete.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: Pallete.darkModeAppTheme,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/add_entry': (context) => const AddScreen(),
        '/analytics': (context) => const AnalyticsScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/about': (context) => const AboutScreen(),
      },
    );
  }
}
