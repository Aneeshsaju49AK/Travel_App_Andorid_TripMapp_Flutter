import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tripmakerflutterapp/controller/favorite_model/favorite_model_controller.dart';
import 'package:tripmakerflutterapp/model/place_model/place_model.dart';

class FavoriteButton extends ChangeNotifier {
  bool isFavorite = false;

  void callRefreshUi() {
    FavoritesDB.instance.updateFavoriteList();
  }

  Future<void> loadFavoriteStatus(ModelPlace place) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isFavorite = prefs.getBool('isFavorite_${place.id}') ?? false;
    notifyListeners();
  }

  Future<void> setFavoriteStatus(ModelPlace place) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isFavorite = !isFavorite;
    print(isFavorite);
    prefs.setBool('isFavorite_${place.id}', isFavorite);
    print("${place.id}");
    notifyListeners();
  }
}
