

import 'package:adminpannelgrocery/responsive.dart';
import 'package:flutter/material.dart';


import '../../../commonWidget/common_text_field_widget.dart';
import '../../../constants.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

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
        if (!Responsive.isMobile(context))
          Text(
            "Dashboard",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
         Expanded(child: SearchField(textChanged: (value ) {  },)),
        const ProfileCard()
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: defaultPadding),
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/images/profile_pic.png",
            height: 38,
          ),
          if (!Responsive.isMobile(context))
            const Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Text("Angelina Jolie"),
            ),
          const Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}

class AddCard extends StatelessWidget {
  final Function(bool) onTap;
  final String text;
  const AddCard(this.text,{
    Key? key,required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: const EdgeInsets.only(left: defaultPadding),
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 3,
      ),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child:  InkWell(
        onTap: (){onTap(true);},
        child:  Row(

          children: [
            Icon(Icons.add),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding / 3),
              child: Text(text),
            ),
          ],
        ),
      ),
    );
  }
}

class Sort extends StatelessWidget {
  const Sort({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/images/profile_pic.png",
            height: 34,
          ),
          //Icon(Icons.filter_2),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            child: Text("Sort"),
          ),
        ],
      ),
    );
  }
}

class SearchField extends StatefulWidget {
  final String? Function(String?)? textChanged;

   const SearchField({
    Key? key,required this.textChanged
  }) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  TextEditingController productname = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 10,bottom: 10),
      child: commonTextFieldWidget(
        type: TextInputType.text,
        controller: productname,
        hintText: "Milk",
        secondaryColor: secondaryColor,
        labelText: "Search",
        onChanged: (val) {
          widget.textChanged!(val);
          },
      ),
    );
  }
}
class HeaderModify extends StatelessWidget {
  const HeaderModify({
    Key? key,
  }) : super(key: key);

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
        if (!Responsive.isMobile(context))
          Text(
            "Dashboard",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        Expanded(child: SearchField(textChanged: (value ) {  },)),

      ],
    );
  }
}
