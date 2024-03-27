import 'package:flutter/material.dart';

class PlaceListNotifier extends ChangeNotifier {
  List<Map<String, dynamic>> _places = []; // Data structure to hold places

  List<Map<String, dynamic>> get places => _places; // Getter for places

  // Method to update places data
  void updatePlaces(List<Map<String, dynamic>> newPlaces) {
    _places = newPlaces;
    notifyListeners(); // Notify listeners about the change
  }
}
