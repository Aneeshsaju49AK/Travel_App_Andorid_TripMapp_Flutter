import 'package:flutter/material.dart';

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
      updateSearchText(searchController.text, (p0) {
        notifyListeners();
      });
    });
  }
}
