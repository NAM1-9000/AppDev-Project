import 'package:expense_tracker/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:expense_tracker/presentation/widgets/auth_screens_button.dart';
import 'package:expense_tracker/stuff/constants.dart';
import 'package:expense_tracker/presentation/widgets/form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // text field controllers
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        } else if (state is AuthSuccess) {
          Navigator.pushReplacementNamed(context, '/main');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                Image.asset(
                  Constants.logoPath,
                  height: 200,
                  width: 200,
                ),

                // app name
                Text(
                  'Expense Tracker',
                  style: Theme.of(context).textTheme.titleLarge,
                ),

                const SizedBox(
                  height: 10,
                ),

                // email and password fields
                FormFieldWidget(
                  controller: emailController,
                  hintText: 'Email',
                  labelText: 'Email',
                  inputType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 10,
                ),
                FormFieldWidget(
                  controller: passwordController,
                  hintText: 'Password',
                  labelText: 'Password',
                  isPasswordField: true,
                ),

                const SizedBox(
                  height: 10,
                ),

                // login and signup buttons
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const CircularProgressIndicator();
                    } else {
                      return AuthScreensButton(
                        buttonLabel: 'Login',
                        onPressed: () {
                          context.read<AuthCubit>().emailPasswordSignIn(
                                emailController.text,
                                passwordController.text,
                              );
                        },
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                AuthScreensButton(
                  buttonLabel: 'Sign Up',
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/signup');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
