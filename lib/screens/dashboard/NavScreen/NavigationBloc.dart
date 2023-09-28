import 'package:adminpannelgrocery/screens/Login/login_screen.dart';
import 'package:adminpannelgrocery/screens/dashboard/NavScreen/AllUserScreen.dart';
import 'package:adminpannelgrocery/screens/dashboard/NavScreen/CategoryScreen.dart';
import 'package:adminpannelgrocery/screens/dashboard/NavScreen/OrderScreen.dart';
import 'package:adminpannelgrocery/screens/dashboard/NavScreen/ProductScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class NavigationBloc extends Cubit<NavigationEvent> {
  final BuildContext context;

  NavigationBloc(this.context) : super(NavigationEvent.navigateToAllUser);

  void navigateToScreen(NavigationEvent event, BuildContext _context) {
    switch (event) {
      case NavigationEvent.navigateToAllUser:
        Navigator.pushReplacement(
          _context,
          MaterialPageRoute(builder: (context) => const AllUserScreen()),
        );
        break;
      case NavigationEvent.navigateToOrder:
        Navigator.pushReplacement(
          _context,
          MaterialPageRoute(builder: (context) => const OrderScreen()),
        );
        break;
      case NavigationEvent.navigateToProducts:
        Navigator.pushReplacement(
          _context,
          MaterialPageRoute(builder: (context) => const ProductScreen()),
        );
        break;
      case NavigationEvent.navigateToCategory:
        Navigator.pushReplacement(
          _context,
          MaterialPageRoute(builder: (context) => const CategoryScreen()),
        );
        break;
      case NavigationEvent.navigateToLogOut:
        Navigator.pushReplacement(
          _context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
        break;
      // Handle more navigation events and navigate to corresponding screens
    }
  }
}

enum NavigationEvent {
  navigateToAllUser,
  navigateToOrder,
  navigateToProducts,
  navigateToCategory,
  navigateToLogOut
  // Add more navigation events as needed
}
