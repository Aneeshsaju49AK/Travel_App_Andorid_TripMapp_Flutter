import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tripmakerflutterapp/provider/common_provider.dart';
import 'package:tripmakerflutterapp/view/screens/user_Screen/loginpage.dart';
import 'package:tripmakerflutterapp/view/widget/commonwidget.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  // Controller for each TextFieldWidget
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  // Key for the Form widget
  final _formKey = GlobalKey<FormState>();

  Future<void> saveUserInfo(String email, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  Future<Map<String, String?>> getUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email = prefs.getString('email');
    final String? password = prefs.getString('password');
    return {'email': email, 'password': password};
  }

  bool _isPassword(String password) {
    return RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).+$').hasMatch(password);
  }

  bool _isEmailValid(String email) {
    return RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(email);
  }

  // // Validation function for each TextFieldWidget
  // String? validateEmail(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return "Please enter a valid email";
  //   }
  //   return null;
  // }

  // String? validatePassword(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return "Please enter a valid password";
  //   }
  //   return null;
  // }

  // String? validatePhone(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return "Please enter a valid phone number";
  //   }
  //   return null;
  // }

  // Function to handle signup button press
  void handleSignupButtonPress(BuildContext context) async {
    // Trigger validation for each TextFieldWidget
    if (_formKey.currentState?.validate() ?? false) {
      // Validation passed, navigate to the login
      String email = emailController.text;
      String password = passwordController.text;
      await saveUserInfo(email, password);

      if (!_isEmailValid(email)) {
        // Show a snackbar with an error message for invalid email format
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid email format'),
          ),
        );
        return;
      }

      if (!_isPassword(password)) {
        // Show a snackbar with an error message for invalid password format
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid password format'),
          ),
        );
        return;
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProviderCommon = Provider.of<CommonProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const HeadWritingWidget(
                    label: "Create account",
                    divideHeight: 6,
                    divideWidth: 1,
                  ),
                  TextFieldWidget(
                    label: "Email",
                    validator: authProviderCommon.validateValue,
                    controller: emailController,
                    onChange: () {
                      if (_formKey.currentState?.validate() == false) {
                        _formKey.currentState?.reset();
                      }
                    },
                  ),
                  TextFieldWidget(
                    label: "Password",
                    validator: authProviderCommon.validateValue,
                    controller: passwordController,
                    // onChange: () {
                    //   if (_formKey.currentState?.validate() == false) {
                    //     _formKey.currentState?.reset();
                    //   }
                    // },
                  ),
                  TextFieldWidget(
                    keyboardType: TextInputType.phone,
                    label: "Phone",
                    validator: authProviderCommon.validateValue,
                    controller: phoneController,
                    // onChange: () {
                    //   if (_formKey.currentState?.validate() == false) {
                    //     _formKey.currentState?.reset();
                    //   }
                    // },
                  ),
                  ButtonCommonWidget(
                    label: "Signup",
                    onPressed: () {
                      // Call the function to handle signup button press
                      handleSignupButtonPress(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
