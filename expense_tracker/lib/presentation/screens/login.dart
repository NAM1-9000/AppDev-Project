// // lib/screens/login_screen.dart
// import 'package:expense_tracker/providers/auth_providers.dart';
// import 'package:expense_tracker/presentation/widgets/form_field.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class LoginScreen extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, ScopedReader watch) {
//     final _emailController = TextEditingController();
//     final _passwordController = TextEditingController();
//     final authService = watch(firebaseAuthServiceProvider);

//     void _login() async {
//       String email = _emailController.text;
//       String password = _passwordController.text;
//       User? user =
//           await authService.signInWithEmailAndPassword(email, password);
//       if (user != null) {
//         print("user logged in");
//         Navigator.pushNamed(context, '/home');
//       } else {
//         print("user not logged in");
//       }
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Login'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             FormFieldWidget(
//               controller: _emailController,
//               hintText: 'Email',
//               labelText: 'Email',
//               inputType: TextInputType.emailAddress,
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             FormFieldWidget(
//               controller: _passwordController,
//               hintText: 'Password',
//               labelText: 'Password',
//               isPasswordField: true,
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             ElevatedButton(
//               onPressed: _login,
//               child: const Text('Login'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, '/signup');
//               },
//               child: const Text('Sign Up'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
