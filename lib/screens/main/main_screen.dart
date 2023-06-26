
import 'package:adminpannelgrocery/screens/dashboard/NavScreen/CategoryScreen.dart';
import 'package:adminpannelgrocery/screens/dashboard/NavScreen/HomeScreen.dart';
import 'package:adminpannelgrocery/screens/dashboard/NavScreen/LogoutScreen.dart';
import 'package:adminpannelgrocery/screens/dashboard/NavScreen/OfferScreen.dart';
import 'package:adminpannelgrocery/screens/dashboard/NavScreen/OrderScreen.dart';

import 'package:adminpannelgrocery/screens/dashboard/NavScreen/ProductScreen.dart';
import 'package:adminpannelgrocery/screens/dashboard/NavScreen/UserScreen.dart';
import 'package:adminpannelgrocery/responsive.dart';
import 'package:adminpannelgrocery/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/MenuController.dart';
import '../../models/AllOrders.dart';
import '../../navigationPackage/NavigationItem.dart';
import 'components/side_menu.dart';


import '../dashboard/NavScreen/ProductScreen.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // Open the drawer
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      key: context.read<MenuController1>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              const Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            const Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: HomeDscreen(),
            ),
          ],
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return buildPages();
  }

  buildPages() {
    final provider = Provider.of<MenuController1>(context);
    final navigationItem = provider.navigationItem;

    switch (navigationItem) {
      case NavigationItem.home:
        return const HomeDscreen();
      case NavigationItem.category:
        return const Categoryscreen();
      case NavigationItem.logout:
        return const Logoutscreen();
      case NavigationItem.offer:
        return const Offerscreen();
      case NavigationItem.users:
        return const UserScreen();
      case NavigationItem.product:
        return  ProductScreen();
      case NavigationItem.order:
        return  OrderScreen();
    }
  }
}
