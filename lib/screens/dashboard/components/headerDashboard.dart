

import 'package:adminpannelgrocery/responsive.dart';
import 'package:flutter/material.dart';


import '../../../commonWidget/common_text_field_widget.dart';
import '../../../constants.dart';

import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {
  final String imageUrl;
  final String name;

  DashboardHeader({required this.imageUrl, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
              icon: const Icon(Icons.menu),
              onPressed: (){
                ScaffoldState? scaffoldState = Scaffold.of(context);
                if (!scaffoldState.isDrawerOpen) {
                  scaffoldState.openDrawer();
                }
              }
          ),
        Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
          Text(
            "Dashboard",
            style: Theme.of(context).textTheme.titleLarge,textAlign: TextAlign.center,
          ),


          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        Column(

          children: [

            CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(imageUrl),
            ),
            SizedBox(height: 8.0),
            Text(
              name,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

