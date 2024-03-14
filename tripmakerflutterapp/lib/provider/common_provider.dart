import 'package:flutter/material.dart';

class CommonProvider extends ChangeNotifier {
  //common validator for all page
  String? validateValue(String? value) {
    if (value == null || value.isEmpty) {
      notifyListeners();
      return "Please enter a valid value";
    }
    return null;
  }
}
