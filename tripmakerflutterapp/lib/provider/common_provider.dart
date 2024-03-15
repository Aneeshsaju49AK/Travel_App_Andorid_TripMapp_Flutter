import 'dart:io';

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

  // common getImageWidget for all page
  Widget getImageWidget(String imagePath) {
    if (imagePath.startsWith("assets/")) {
      notifyListeners();
      return Image.asset(
        imagePath,
        fit: BoxFit.cover,
      );
    } else {
      notifyListeners();
      return Image.file(
        File(imagePath),
        fit: BoxFit.cover,
      );
    }
  }
}
