import 'package:expense_tracker/core/common/google_sign_in_button.dart';
import 'package:expense_tracker/core/common/loader.dart';
import 'package:expense_tracker/core/constants/constants.dart';
import 'package:expense_tracker/core/failure.dart';
import 'package:expense_tracker/features/auth/controller/auth_controller.dart';
import 'package:expense_tracker/presentation/widgets/form_field.dart';
import 'package:expense_tracker/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: isLoading
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.all(16.0),
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
                  FormFieldWidget(
                    controller: _confirmPasswordController,
                    hintText: 'Confirm Password',
                    labelText: 'Confirm Password',
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
                      final email = _emailController.text;
                      final password = _passwordController.text;
                      final confirmPassword = _confirmPasswordController.text;

                      if (password == confirmPassword) {
                        ref
                            .read(authControllerProvider.notifier)
                            .signUpWithEmailAndPassword(
                                context, email, password);
                      } else {
                        Failure('Password does not match');
                        print("Password does not match");
                      }
                    },
                    child: const Text('Sign Up'),
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
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: const Text('Login'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SignInGoogle()
                ],
              ),
            ),
    );
    ;
  }
}
