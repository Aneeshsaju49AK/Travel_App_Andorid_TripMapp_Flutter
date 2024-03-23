import 'package:flutter/material.dart';

class TabViewProvider extends ChangeNotifier {
  late final TabController _tabController;
  late PageController _pageController;
  double _currentIndex = 0;

  TabController get controller => _tabController;
  void initTabController(TickerProvider key) {
    _tabController = TabController(
      length: 3,
      vsync: key,
    );
    notifyListeners();
  }

  void disposeController() {
    _tabController.dispose();
  }

  double get currentIdex => _currentIndex;
  PageController get controllerpage => _pageController;
  void initPageController() {
    _pageController = PageController(
      initialPage: 0,
    );
    _pageController.addListener(() {
      _currentIndex = _pageController.page!;
    });
    notifyListeners();
  }
}
