import 'package:flutter/material.dart';

PreferredSize buildAppBar(String title, String text1, String text2) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(100),
    child: AppBar(
      title: Text(title),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              text1,
              style: const TextStyle(fontSize: 30),
            ),
            Text(text2, style: const TextStyle(fontSize: 30)),
          ],
        ),
      ),
      centerTitle: true,
    ),
  );
}
