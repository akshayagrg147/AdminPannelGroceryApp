import 'package:flutter/material.dart';

import '../navigationPackage/NavigationItem.dart';

class DrawController extends ChangeNotifier {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  NavigationItem navigationItem = NavigationItem.home;

  // NavigationItem get navigationItem => _navigationItem;

  void setNavigationItem(NavigationItem navigationItemLocal) {
    navigationItem = navigationItemLocal;
    notifyListeners();
  }
}
