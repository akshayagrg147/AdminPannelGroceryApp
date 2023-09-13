import 'package:flutter/material.dart';

import '../constants.dart';
import '../responsive.dart';

class commonTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final Color secondaryColor;
  final double defaultPadding;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Function(String) onChanged;
  final double padding;
  final double margin;
  final Decoration decoration;
  final TextInputType type;
  final IconData icon;


  commonTextFieldWidget({
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.secondaryColor,
    required this.type,
    this.defaultPadding=16.0,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
     required this.onChanged,
    this.padding = 1.0,
    this.margin = 10.0,
    this.decoration = const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    this.icon=Icons.ac_unit_sharp,


  });

  @override
  Widget build(BuildContext context) {

    return Container(


      child: TextField(
        controller: controller,

        obscureText: obscureText,
        keyboardType: type,
        textInputAction: textInputAction,
        cursorColor: kPrimaryColor,
        onChanged: onChanged,
        maxLines: null, // Unlimited lines


        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          //fillColor: Colors.white,
          fillColor: secondaryColor,

          filled: true
          , border: OutlineInputBorder(
      /*    borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(10.0),*/
          // Set the border color to grey
        ),
          prefixIcon: InkWell(
            onTap: () {},
            child: Container(
              padding:  EdgeInsets.all(defaultPadding * 0.75),
              margin:  EdgeInsets.symmetric(
                  horizontal: defaultPadding / 2),
              decoration:  BoxDecoration(
                //color: Colors.black,

                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child:  ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black, // Change this to your desired tint color
                  BlendMode.srcIn,
                ),
                child:Icon(icon,

              )),
            ),
          ),
          labelStyle: TextStyle(color: Colors.black), // Change label text color
          hintStyle: TextStyle(color: Colors.black),
        ),
      ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey, // Set the border color
            width: 1.0,          // Set the border width
          ),
        )

    );
  }
}
