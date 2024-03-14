import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tripmakerflutterapp/view/screens/admin_Screen/admin_Home_Screen.dart';
import 'package:tripmakerflutterapp/view/screens/user_Screen/home_Screen.dart';
import 'package:tripmakerflutterapp/view/screens/user_Screen/loginpage.dart';

class ProviderMain_Page with ChangeNotifier {
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

  // Login page
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // GlobalKey<FormState> get formKey => _formKey;

  // void handleLoginButtonPress(BuildContext context) async {
  //   if (_formKey.currentState?.validate() ?? false) {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     String? storedEmail = prefs.getString('email');
  //     String? storedPassword = prefs.getString('password');
  //     bool isAdmin = prefs.getBool('isAdmin') ?? false;

  //     String enteredEmail = emailController.text;
  //     String enteredPassword = passwordController.text;

  //     if (enteredEmail == 'admin@gmail.com' && enteredPassword == 'admin') {
  //       prefs.setBool('isLoggedIn', true);
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => ScreenHomeAdmin(),
  //         ),
  //       );
  //     } else if (storedEmail == enteredEmail &&
  //         storedPassword == enteredPassword) {
  //       prefs.setBool('isLoggedIn', true);
  //       if (isAdmin) {
  //         Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => ScreenHomeAdmin(),
  //           ),
  //         );
  //       } else {
  //         Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => ScreenSelection(),
  //           ),
  //         );
  //       }
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('Invalid credentials. Please try again.'),
  //         ),
  //       );
  //     }
  //   }
  //   notifyListeners();
  // }
}
