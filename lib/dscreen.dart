import 'package:adminpannelgrocery/screens/dashboard/dashboard_screen.dart';
import 'package:adminpannelgrocery/screens/main/components/side_menu.dart';
import 'package:flutter/material.dart';

class dscreen extends StatefulWidget {
  const dscreen({Key? key}) : super(key: key);

  @override
  State<dscreen> createState() => _dscreenState();
}

class _dscreenState extends State<dscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(title: Text("Dash board screen"),),
      body: DashboardScreen(),
    );
  }
}
