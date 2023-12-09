import 'package:flutter/material.dart';

final messengerKey = GlobalKey<ScaffoldMessengerState>();

class Utils {
  static showSnackBar(String? text) {
    if (text == null) return;
    final val = SnackBar(
      content: Text(text),
      backgroundColor: Colors.red,
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(val);
  }

  static showSnackBar1(String? text) {
    if (text == null) return;
    final val = SnackBar(
      content: Text(text),
      backgroundColor: Colors.cyan[500],
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(val);
  }

  static showSnackBar2(String? text) {
    if (text == null) return;
    final val = SnackBar(
      content: Text(
        text,
        style: TextStyle(color: Colors.cyan[500]),
      ),
      backgroundColor: Colors.white,
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(val);
  }
}