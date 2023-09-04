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
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: type,
      textInputAction: textInputAction,
      cursorColor: kPrimaryColor,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        //fillColor: Colors.white,
        fillColor: secondaryColor,
        filled: true
        ,
        prefixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding:  EdgeInsets.all(defaultPadding * 0.75),
            margin:  EdgeInsets.symmetric(
                horizontal: defaultPadding / 2),
            decoration: const BoxDecoration(
              //color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child:  Icon(Icons.ac_unit_sharp,

            ),
          ),
        ),
      ),
    );
  }
}
