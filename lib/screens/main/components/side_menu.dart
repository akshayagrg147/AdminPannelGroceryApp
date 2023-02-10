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
          DrawerHeader(
            child: Image.asset("assets/images/logo.png"),
          ),
          DrawerListTile(
            title: "Home",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {
              selectItem(context, NavigationItem.home);
            },
          ),
          DrawerListTile(
            title: "Products",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {selectItem(context, NavigationItem.product);},
          ),
          DrawerListTile(
            title: "Category",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {selectItem(context, NavigationItem.category);},
          ),
          DrawerListTile(
            title: "Order",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {selectItem(context, NavigationItem.order);},
          ),
          DrawerListTile(
            title: "Offer",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {selectItem(context, NavigationItem.offer);},
          ),
          DrawerListTile(
            title: "Users",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () {selectItem(context, NavigationItem.users);},
          ),

          DrawerListTile(
            title: "Log out",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {selectItem(context, NavigationItem.logout);},
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
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
