import 'package:flutter/material.dart';
import 'package:tripmakerflutterapp/controller/place_model/place_model_controller.dart';

class SearchProvider extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  void updateSearchText(String searchText, void Function(String)? onSearch) {
    if (onSearch != null) {
      onSearch(searchText);
      notifyListeners();
    }
  }

  void listenText() {
    searchController.addListener(() {
      PlacesDB.instance.reFreshUI();
      updateSearchText(searchController.text, (p0) {
        notifyListeners();
      });
    });
  }
}
