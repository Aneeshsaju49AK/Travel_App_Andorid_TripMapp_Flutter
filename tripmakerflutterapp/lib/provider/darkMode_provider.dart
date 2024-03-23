import 'package:flutter/material.dart';

class DarkModeProvider extends ChangeNotifier {
  bool _value = false;

  bool get value => _value;

  void setValue(bool isDarkModeEnabled) {
    _value = isDarkModeEnabled;
    notifyListeners();
  }
}
