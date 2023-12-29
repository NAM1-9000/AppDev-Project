import 'package:expense_tracker/stuff/constants.dart';
import 'package:expense_tracker/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInGoogle extends ConsumerWidget {
  const SignInGoogle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton.icon(
      onPressed: () => {},
      icon: Image.asset(
        Constants.googleLogoPath,
        width: 35,
      ),
      label: const Text(
        'Sign in with Google',
      ),
      style: ElevatedButton.styleFrom(
          backgroundColor: Pallete.greyColor,
          minimumSize:
              Size(double.infinity, MediaQuery.of(context).size.height * 0.06),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
    );
  }
}
