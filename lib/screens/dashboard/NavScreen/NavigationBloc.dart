import 'package:adminpannelgrocery/screens/dashboard/NavScreen/AllUserScreen.dart';
import 'package:adminpannelgrocery/screens/dashboard/NavScreen/OrderScreen.dart';
import 'package:adminpannelgrocery/screens/dashboard/NavScreen/ProductScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';


class NavigationBloc extends Cubit<NavigationEvent>{
  final BuildContext context;
  NavigationBloc(this.context) : super(NavigationEvent.navigateToAllUser);


  void navigateToScreen(NavigationEvent event, BuildContext _context) {
    switch (event) {
      case NavigationEvent.navigateToAllUser:
        Navigator.push(
          _context,
          MaterialPageRoute(builder: (context) => const AllUserScreen()),
        );
        break;
      case NavigationEvent.navigateToOrder:
        Navigator.push(
          _context,
          MaterialPageRoute(builder: (context) => const OrderScreen()),
        );
        break;
      case NavigationEvent.navigateToProducts:
        Navigator.push(
          _context,
          MaterialPageRoute(builder: (context) => const ProductScreen()),
        );
        break;
    // Handle more navigation events and navigate to corresponding screens
    }
  }


}
enum NavigationEvent {
  navigateToAllUser,
  navigateToOrder,
  navigateToProducts
  // Add more navigation events as needed
}