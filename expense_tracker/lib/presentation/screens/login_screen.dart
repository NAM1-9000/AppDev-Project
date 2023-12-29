import 'package:expense_tracker/stuff/constants.dart';
import 'package:expense_tracker/presentation/widgets/google_sign_in_button.dart';
import 'package:expense_tracker/presentation/widgets/form_field.dart';
import 'package:expense_tracker/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Constants.logoPath,
                height: 200,
                width: 200,
              ),
              Text('Expense Tracker',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(
                height: 10,
              ),
              FormFieldWidget(
                controller: _emailController,
                hintText: 'Email',
                labelText: 'Email',
                inputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 10,
              ),
              FormFieldWidget(
                controller: _passwordController,
                hintText: 'Password',
                labelText: 'Password',
                isPasswordField: true,
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Pallete.greyColor,
                    minimumSize: Size(double.infinity,
                        MediaQuery.of(context).size.height * 0.06),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
                child: const Text('Login'),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Pallete.greyColor,
                    minimumSize: Size(double.infinity,
                        MediaQuery.of(context).size.height * 0.06),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/signup');
                },
                child: const Text('Sign Up'),
              ),
              const SizedBox(
                height: 10,
              ),
              const SignInGoogle()
            ],
          ),
        ),
      ),
    );
  }
}
