import 'package:adminpannelgrocery/screens/dashboard/NavScreen/CategoryScreen.dart';

import 'package:adminpannelgrocery/screens/dashboard/NavScreen/LogoutScreen.dart';
import 'package:adminpannelgrocery/screens/dashboard/NavScreen/OfferScreen.dart';
import 'package:adminpannelgrocery/screens/dashboard/NavScreen/OrderScreen.dart';

import 'package:adminpannelgrocery/screens/dashboard/NavScreen/ProductScreen.dart';
import 'package:adminpannelgrocery/screens/dashboard/NavScreen/UserScreen.dart';
import 'package:adminpannelgrocery/responsive.dart';
import 'package:adminpannelgrocery/screens/dashboard/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/MenuController.dart';
import '../../models/AllOrders.dart';
import '../../navigationPackage/NavigationItem.dart';
import 'components/side_menu.dart';

import '../dashboard/NavScreen/ProductScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {


  @override
  Widget build(BuildContext context) {
    return Consumer<MenuController1>(
      builder: (_,consumer,__) {
       var x=  consumer.navigationItem;
        return Scaffold(

          drawer: SideMenu(),
          body: buildPages(x),);
      }
    );
  }


  buildPages(var navigationItem) {
    switch (navigationItem) {
      case NavigationItem.home:
        return  HomeScreen();
      case NavigationItem.category:
        return const CategoryScreen();
      case NavigationItem.logout:
        return const Logoutscreen();
      case NavigationItem.offer:
        return const Offerscreen();
      case NavigationItem.users:
        return const UserScreen();
      case NavigationItem.product:
        return ProductScreen();
      case NavigationItem.order:
        return OrderScreen();
    }
  }

}