import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:jal_anveshak/Screens/UserPage.dart';
import 'package:jal_anveshak/Auth/Login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getFlagValuesSF(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshot.hasData) {
          return const Login();
        }
        if (snapshot.hasData && snapshot.data![0] == null) {
          return const Login();
        }
        if (snapshot.hasData && snapshot.data![0]) {
          return UserPage(
            name: snapshot.data![1],
            token: snapshot.data![2],
            userId: snapshot.data![3],
          );
        }
        if (snapshot.hasData && !snapshot.data![0]) {
          return const Login();
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

Future<List?> getFlagValuesSF() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('isLoggedIn');
    String? name = prefs.getString('name');
    String? token = prefs.getString('token');
    String? userId = prefs.getString('userId');
    return [isLoggedIn, name, token, userId];
  } catch (e) {
    if (kDebugMode) {
      print(e.toString());
    }
  }
  return null;
}
