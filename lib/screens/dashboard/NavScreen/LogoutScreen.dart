import 'package:adminpannelgrocery/responsive.dart';
import 'package:adminpannelgrocery/screens/dashboard/home_screen.dart';
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
    return Scaffold(body: HomeScreen());
  }
}
