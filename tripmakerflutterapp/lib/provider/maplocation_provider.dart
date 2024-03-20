import 'package:flutter/material.dart';
import 'package:tripmakerflutterapp/model/place_model/place_model.dart';

class MapLocationProvider extends ChangeNotifier {
  bool showFullText = false;
  late ModelPlace _currentPlace;
  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;
  ModelPlace get currentPlace => _currentPlace;
  void initValue(ModelPlace place) {
    _currentPlace = place;
    notifyListeners();
  }

  void checkIsFavorite(bool isFavoriteWidget) {
    _isFavorite = isFavoriteWidget;
  }

  void changeValue() {
    showFullText = !showFullText;
    notifyListeners();
  }
}
