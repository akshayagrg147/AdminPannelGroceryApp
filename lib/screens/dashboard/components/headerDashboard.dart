import 'package:adminpannelgrocery/responsive.dart';
import 'package:flutter/material.dart';

import '../../../commonWidget/common_text_field_widget.dart';
import '../../../constants.dart';

import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String title;

  DashboardHeader(
      {required this.imageUrl, required this.name, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onPressed: () {
                ScaffoldState? scaffoldState = Scaffold.of(context);
                if (!scaffoldState.isDrawerOpen) {
                  scaffoldState.openDrawer();
                }
              }),
        Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Column(
            children: [
              if (imageUrl.isNotEmpty)
                CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(imageUrl),
                ),
              SizedBox(height: 8.0),
              if (imageUrl.isNotEmpty)
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
