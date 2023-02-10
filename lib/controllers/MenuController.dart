

import 'package:flutter/material.dart';

import '../navigationPackage/NavigationItem.dart';

class MenuController1 extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  NavigationItem _navigationItem = NavigationItem.home;
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  NavigationItem get navigationItem => _navigationItem;
  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }
  void setNavigationItem(NavigationItem navigationItem) {
    _navigationItem = navigationItem;

    notifyListeners();
  }
}
