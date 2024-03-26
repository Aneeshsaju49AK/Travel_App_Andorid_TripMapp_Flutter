import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tripmakerflutterapp/controller/place_model/place_model_controller.dart';

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
      return Image.file(
        File(imagePath),
        fit: BoxFit.cover,
      );
    }
  }

  void callRefreshUI() {
    PlacesDB.instance.reFreshUI();
  }
}
