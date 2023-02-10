import 'package:adminpannelgrocery/responsive.dart';
import 'package:adminpannelgrocery/screens/dashboard/dashboard_screen.dart';
import 'package:adminpannelgrocery/screens/main/components/side_menu.dart';
import 'package:flutter/material.dart';

class Offerscreen extends StatefulWidget {
  const Offerscreen({Key? key}) : super(key: key);

  @override
  State<Offerscreen> createState() => _OfferscreenState();
}

class _OfferscreenState extends State<Offerscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: SideMenu(),

    body: SafeArea(
    child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    if (Responsive.isDesktop(context))
    Expanded(
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
