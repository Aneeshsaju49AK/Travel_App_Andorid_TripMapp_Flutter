import 'package:flutter/material.dart';

class MapLocationProvider extends ChangeNotifier {
  bool showFullText = false;
  void changeValue() {
    showFullText = !showFullText;
    notifyListeners();
  }
}
