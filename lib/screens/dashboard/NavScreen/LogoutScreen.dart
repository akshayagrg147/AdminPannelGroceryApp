import 'package:adminpannelgrocery/responsive.dart';
import 'package:adminpannelgrocery/screens/dashboard/dashboard_screen.dart';
import 'package:adminpannelgrocery/screens/main/components/side_menu.dart';
import 'package:flutter/material.dart';

class Logoutscreen extends StatefulWidget {
  const Logoutscreen({Key? key}) : super(key: key);

  @override
  State<Logoutscreen> createState() => _LogoutscreenState();
}

class _LogoutscreenState extends State<Logoutscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const SideMenu(),
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (Responsive.isDesktop(context))
                const Expanded(
                  child: SideMenu(),
                ),
              Expanded(
                flex: 5,
                child: HomeScreen(),
              ),
            ],
          ),
        ));
  }
}
