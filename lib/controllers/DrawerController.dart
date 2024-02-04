import 'package:flutter/material.dart';

import '../navigationPackage/NavigationItem.dart';


class DrawController extends ChangeNotifier {
  NavigationItem _currentNavigationItem = NavigationItem.home;

  NavigationItem get currentNavigationItem => _currentNavigationItem;

  void setNavigationItem(NavigationItem item) {
    _currentNavigationItem = item;
    notifyListeners();
  }
}
