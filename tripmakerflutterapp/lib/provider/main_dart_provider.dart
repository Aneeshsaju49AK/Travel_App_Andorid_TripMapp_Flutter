import 'dart:async';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:tripmakerflutterapp/view/screens/user_Screen/home_Screen.dart';
import 'package:tripmakerflutterapp/view/screens/user_Screen/loginpage.dart';

class ProviderMainPage with ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  // isLoggedIn in splash screen
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  Future<void> initializeMainPage(BuildContext context) async {
    await Timer(
      Duration(seconds: 3),
      () async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

        if (_isLoggedIn) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ScreenSelection(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
        }
        notifyListeners();
      },
    );
  }
}
