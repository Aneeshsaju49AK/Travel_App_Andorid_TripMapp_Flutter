import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tripmakerflutterapp/provider/common_provider.dart';
import 'package:tripmakerflutterapp/view/screens/admin_Screen/admin_Home_Screen.dart';
import 'package:tripmakerflutterapp/view/screens/user_Screen/signinpage.dart';
import 'package:tripmakerflutterapp/view/screens/user_Screen/home_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widget/common_widget/populatList_folder/commonwidget.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // Controller for each TextFieldWidget
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  // Key for the Form widget
  final _formKey = GlobalKey<FormState>();

  // Validation function for each TextFieldWidget
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a valid email";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a valid password";
    }
    return null;
  }

  // Function to handle login button press
  void handleLoginButtonPress(BuildContext context) async {
    // Trigger validation for each TextFieldWidget
    if (_formKey.currentState?.validate() ?? false) {
      // Validation passed, check user credentials

      // Retrieve user info from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? storedEmail = prefs.getString('email');
      String? storedPassword = prefs.getString('password');
      bool isAdmin = prefs.getBool('isAdmin') ?? false;

      // Get the entered email and password
      String enteredEmail = emailController.text;
      String enteredPassword = passwordController.text;

      if (enteredEmail == 'admin@gmail.com' && enteredPassword == 'admin') {
        prefs.setBool('isLoggedIn', true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ScreenHomeAdmin();
            },
          ),
        );
      } else if (storedEmail == enteredEmail &&
          storedPassword == enteredPassword) {
        prefs.setBool('isLoggedIn', true);
        if (isAdmin) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ScreenHomeAdmin(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ScreenSelection(),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid credentials. Please try again.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CommonProvider>(
      builder: (context, value, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: SafeArea(
              child: SizedBox(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const HeadWritingWidget(
                        label: "Login",
                        divideHeight: 6,
                        divideWidth: 1,
                      ),
                      TextFieldWidget(
                        label: "Email",
                        validator: value.validateValue,
                        controller: emailController,
                        onChange: () {
                          if (_formKey.currentState?.validate() == false) {
                            _formKey.currentState?.reset();
                          }
                        },
                      ),
                      TextFieldWidget(
                        label: "Password",
                        validator: value.validateValue,
                        controller: passwordController,
                        // onChange: () {
                        //   if (_formKey.currentState?.validate() == false) {
                        //     _formKey.currentState?.reset();
                        //   }
                        // },
                      ),
                      ButtonCommonWidget(
                        label: "Login",
                        onPressed: () {
                          // Call the function to handle login button press
                          handleLoginButtonPress(context);
                        },
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                              left: 60,
                            ),
                            child: Text("If you don't have an account?"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignInPage(),
                                ),
                              );
                            },
                            child: const Text("SignIn"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
