import 'package:adminpannelgrocery/screens/dashboard/NavScreen/BannerScreen.dart';
import 'package:adminpannelgrocery/screens/dashboard/NavScreen/CategoryScreen.dart';
import 'package:adminpannelgrocery/screens/dashboard/NavScreen/CouponScreen.dart';

import 'package:adminpannelgrocery/screens/dashboard/NavScreen/LogoutScreen.dart';
import 'package:adminpannelgrocery/screens/dashboard/NavScreen/OfferScreen.dart';
import 'package:adminpannelgrocery/screens/dashboard/NavScreen/OrderScreen.dart';

import 'package:adminpannelgrocery/screens/dashboard/NavScreen/ProductScreen.dart';
import 'package:adminpannelgrocery/responsive.dart';
import 'package:adminpannelgrocery/screens/dashboard/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/DrawerController.dart';
import '../../models/AllOrders.dart';
import '../../navigationPackage/NavigationItem.dart';
import '../Login/login_screen.dart';
import '../dashboard/NavScreen/AllUserScreen.dart';
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
    return Consumer<DrawController>(
      builder: (_,consumer,__) {
       var x=  consumer.navigationItem;
        return Scaffold(

          drawer: SideMenu(false),
          body: buildPages(x),);
      }
    );
  }
  void navigateToLoginScreen(BuildContext context) {
    Future.delayed(Duration.zero, () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }


  buildPages(var navigationItem) {
    switch (navigationItem) {
      case NavigationItem.home:
        return  HomeScreen();
      case NavigationItem.category:
        return const CategoryScreen();
      case NavigationItem.logout:
          navigateToLoginScreen(context);
        return SizedBox();
      case NavigationItem.banner:
        return const BannerScreen();

      case NavigationItem.users:
        return const AllUserScreen();
      case NavigationItem.product:
        return ProductScreen();
      case NavigationItem.order:
        return OrderScreen();
      case NavigationItem.coupons:
        return CouponScreen();

    }
  }

}