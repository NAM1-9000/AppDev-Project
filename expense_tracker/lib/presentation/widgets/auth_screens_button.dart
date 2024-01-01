import 'package:flutter/material.dart';

class AuthScreensButton extends StatelessWidget {
  const AuthScreensButton({
    super.key,
    required this.buttonLabel,
    required this.onPressed,
  });

  final String buttonLabel;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        //backgroundColor: Pallete.greyColor,
        minimumSize: Size(
          double.infinity,
          MediaQuery.of(context).size.height * 0.06,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: onPressed as void Function()?,
      child: Text(buttonLabel),
    );
  }
}
