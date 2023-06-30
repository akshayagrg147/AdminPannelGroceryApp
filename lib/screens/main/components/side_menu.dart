import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../controllers/MenuController.dart';
import '../../../navigationPackage/NavigationItem.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  late final MenuController1 provider;

  @override
  void initState() {
    provider = Provider.of<MenuController1>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
              //child: Text("Grocery Dashboard"),

              ),
          DrawerHeader(
            child: Image.asset("assets/images/logo.png"),
          ),
          DrawerListTile(
            title: "Home",
            press: () {
              Navigator.pop(context);
             provider.setNavigationItem(NavigationItem.home);
            },
          ),
          DrawerListTile(
            title: "Products",
            press: () {
              Navigator.pop(context);
             provider.setNavigationItem(NavigationItem.product);
            },
          ),
          DrawerListTile(
            title: "Category",
            press: () {
              Navigator.pop(context);
              selectItem(context, NavigationItem.category,provider);
            },
          ),
          DrawerListTile(
            title: "Order",
            press: () {
              Navigator.pop(context);
              selectItem(context, NavigationItem.order, provider);
            },
          ),
          DrawerListTile(
            title: "Offer",
            press: () {
              Navigator.pop(context);
              selectItem(context, NavigationItem.offer,provider);
            },
          ),
          DrawerListTile(
            title: "Users",
            press: () {
              Navigator.pop(context);
              selectItem(context, NavigationItem.users, provider);
            },
          ),
          DrawerListTile(
            title: "Log out",
            press: () {
              Navigator.pop(context);
              selectItem(context, NavigationItem.logout,provider);
            },
          ),
        ],
      ),
    );
  }
}

void selectItem(
    BuildContext context, NavigationItem item, MenuController1 provider) {
  provider.setNavigationItem(item);
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.press,
  }) : super(key: key);

  final String title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
