import 'package:expense_tracker/presentation/screens/about_screen.dart';
import 'package:expense_tracker/presentation/screens/main%20screen/analytics_body.dart';
import 'package:expense_tracker/presentation/screens/main%20screen/home_body.dart';
import 'package:expense_tracker/presentation/screens/main%20screen/main_screen.dart';
import 'package:expense_tracker/presentation/screens/main%20screen/settings_body.dart';
import 'package:expense_tracker/presentation/screens/signup_screen.dart';
import 'package:expense_tracker/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:expense_tracker/presentation/screens/login_screen.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  testGoldens('Login Screen Test', (tester) async {
    const widget = MaterialApp(
      home: LoginScreen(),
    );

    await tester.pumpWidgetBuilder(
      widget,
      surfaceSize: const Size(500, 1000),
    );

    await screenMatchesGolden(tester, 'LoginScreen Screenshot');
  });

  testGoldens('Signup Screen Test', (tester) async {
    const widget = MaterialApp(
      home: SignupScreen(),
    );

    await tester.pumpWidgetBuilder(
      widget,
      surfaceSize: const Size(500, 1000),
    );

    await screenMatchesGolden(tester, 'SignupScreen Screenshot');
  });

  testGoldens('Settings Screen Test', (tester) async {
    const widget = MaterialApp(
      home: SettingsBody(),
    );

    await tester.pumpWidgetBuilder(
      widget,
      surfaceSize: const Size(500, 1000),
    );

    await screenMatchesGolden(tester, 'SettingsBody Screenshot');
  });

  testGoldens('Home Screen Test', (tester) async {
    const widget = MaterialApp(
      home: HomeBody(),
    );

    await tester.pumpWidgetBuilder(
      widget,
      surfaceSize: const Size(500, 1000),
    );

    await screenMatchesGolden(tester, 'HomeBody Screenshot');
  });

  testGoldens('Analytics Screen Test', (tester) async {
    const widget = MaterialApp(
      home: AnalyticsBody(),
    );

    await tester.pumpWidgetBuilder(
      widget,
      surfaceSize: const Size(500, 1000),
    );

    await screenMatchesGolden(tester, 'AnalyticsBosy Screenshot');
  });

  testGoldens('Main Screen Test', (tester) async {
    const widget = MaterialApp(
      home: MainScreen(),
    );

    await tester.pumpWidgetBuilder(
      widget,
      surfaceSize: const Size(500, 1000),
    );

    await screenMatchesGolden(tester, 'MainScreen Screenshot');
  });

  testGoldens('About Screen Test', (tester) async {
    const widget = MaterialApp(
      home: AboutScreen(),
    );

    await tester.pumpWidgetBuilder(
      widget,
      surfaceSize: const Size(500, 1000),
    );

    await screenMatchesGolden(tester, 'AboutScreen Screenshot');
  });

  testGoldens('Splash Screen Test', (tester) async {
    const widget = MaterialApp(
      home: SplashScreen(),
    );

    await tester.pumpWidgetBuilder(
      widget,
      surfaceSize: const Size(500, 1000),
    );

    // Wait for the asynchronous operation to complete
    await tester.pumpAndSettle(const Duration(seconds: 3));

    await screenMatchesGolden(tester, 'SplashScreen Screenshot');
  });
}
