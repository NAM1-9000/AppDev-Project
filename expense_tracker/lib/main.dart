import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:expense_tracker/business%20logic/cubits/entry/add_entry_cubit.dart';
import 'package:expense_tracker/business%20logic/cubits/theme/theme_cubit.dart';
import 'package:expense_tracker/business%20logic/cubits/theme/theme_state.dart';
import 'package:expense_tracker/firebase_options.dart';
import 'package:expense_tracker/presentation/screens/about_screen.dart';
import 'package:expense_tracker/presentation/screens/add_entry_screen.dart';
import 'package:expense_tracker/presentation/screens/login_screen.dart';
import 'package:expense_tracker/presentation/screens/main%20screen/main_screen.dart';
import 'package:expense_tracker/presentation/screens/settings_screen.dart';
import 'package:expense_tracker/presentation/screens/signup_screen.dart';
import 'package:expense_tracker/presentation/screens/splash_screen.dart';
import 'package:expense_tracker/utils/pallete.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => AddEntryCubit()),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (themeContext, themeState) {
        ThemeData currentTheme = Pallete.lightModeAppTheme;
        if (themeState is ThemeChanged) {
          currentTheme = themeState.themeData;
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Expense Tracker',
          theme: currentTheme, // Use the current theme from the ThemeCubit
          initialRoute: '/splash',
          routes: {
            '/splash': (context) => const SplashScreen(),
            '/main': (context) => const MainScreen(),
            '/login': (context) => const LoginScreen(),
            '/signup': (context) => const SignupScreen(),
            '/add_entry': (context) => const AddEntryScreen(),
            //'/analytics': (context) => const AnalyticsScreen(),
            '/settings': (context) => const SettingsScreen(),
            '/about': (context) => const AboutScreen(),
            //syncfusion
          },
        );
      },
    );
  }
}
