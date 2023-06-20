import 'package:adminpannelgrocery/screens/dashboard/NavScreen/AllUserScreen.dart';
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
      case NavigationEvent.navigateToScreen2:
        Navigator.push(
          _context,
          MaterialPageRoute(builder: (context) => const AllUserScreen()),
        );
        break;
    // Handle more navigation events and navigate to corresponding screens
    }
  }


}
enum NavigationEvent {
  navigateToAllUser,
  navigateToScreen2,
  // Add more navigation events as needed
}