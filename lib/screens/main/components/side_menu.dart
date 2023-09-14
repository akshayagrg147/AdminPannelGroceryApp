import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../controllers/DrawerController.dart';
import '../../../navigationPackage/NavigationItem.dart';

class SideMenu extends StatefulWidget {
  final isDesktop;
  const SideMenu(this.isDesktop, {
    Key? key,
  }) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  late final DrawController provider;

  @override
  void initState() {
    provider = Provider.of<DrawController>(context, listen: false);
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
            child: Image.asset("assets/images/logo_dashboard.png"),
          ),
          DrawerListTile(
            title: "Home",
            press: () {
              if(!widget.isDesktop)
              Navigator.pop(context);
             provider.setNavigationItem(NavigationItem.home);
            },
          ),
          DrawerListTile(
            title: "Products",
            press: () {
              if(!widget.isDesktop)
              Navigator.pop(context);
             provider.setNavigationItem(NavigationItem.product);
            },
          ),
          DrawerListTile(
            title: "Category",
            press: () {
              if(!widget.isDesktop)
              Navigator.pop(context);
              selectItem(context, NavigationItem.category,provider);
            },
          ),
          DrawerListTile(
            title: "Order",
            press: () {
              if(!widget.isDesktop)
              Navigator.pop(context);
              selectItem(context, NavigationItem.order, provider);
            },
          ),
          DrawerListTile(
            title: "Add Banner",
            press: () {
              if(!widget.isDesktop)
              Navigator.pop(context);
              selectItem(context, NavigationItem.banner,provider);
            },
          ),
          DrawerListTile(
            title: "Users",
            press: () {
              if(!widget.isDesktop)
              Navigator.pop(context);
              selectItem(context, NavigationItem.users, provider);
            },
          ),
          DrawerListTile(
            title: "Coupons",
            press: () {
              if(!widget.isDesktop)
              Navigator.pop(context);
              selectItem(context, NavigationItem.coupons, provider);
            },
          ),
          DrawerListTile(
            title: "Log out",
            press: () {
              if(!widget.isDesktop)
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
    BuildContext context, NavigationItem item, DrawController provider) {
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
