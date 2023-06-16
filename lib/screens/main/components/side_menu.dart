import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../controllers/MenuController.dart';
import '../../../navigationPackage/NavigationItem.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

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
              selectItem(context, NavigationItem.home);
            },
          ),
          DrawerListTile(
            title: "Products",

            press: () {
              selectItem(context, NavigationItem.product);
            },
          ),
          DrawerListTile(
            title: "Category",

            press: () {
              selectItem(context, NavigationItem.category);
            },
          ),
          DrawerListTile(
            title: "Order",

            press: () {
              selectItem(context, NavigationItem.order);
            },
          ),
          DrawerListTile(
            title: "Offer",

            press: () {
              selectItem(context, NavigationItem.offer);
            },
          ),
          DrawerListTile(
            title: "Users",

            press: () {
              selectItem(context, NavigationItem.users);
            },
          ),
          DrawerListTile(
            title: "Log out",

            press: () {
              selectItem(context, NavigationItem.logout);
            },
          ),
        ],
      ),
    );
  }
}

void selectItem(BuildContext context, NavigationItem item) {
  final provider = Provider.of<MenuController1>(context, listen: false);
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
