
import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield(
      {super.key,
        required this.label,
        required this.controller,
        this.obsecureText,
        this.errorText,
        this.suffixIcon,
        this.validator});
  final String label;
  final TextEditingController controller;
  final bool? obsecureText;
  final Widget? suffixIcon;
  final String? errorText;
  final String? Function(String?)? validator;
  @override  State<CustomTextfield> createState() => _CustomTextfieldState();
}
class _CustomTextfieldState extends State<CustomTextfield> {
  bool showPassword = true;
  @override  Widget build(BuildContext context) {
    return widget.obsecureText ?? false        ? SizedBox(
      width: SizeConfig.widthMultiplier! * 384,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
          ),
          SizedBox(
            height: SizeConfig.heightMultiplier! * 10,
          ),
          Container(
            height: SizeConfig.heightMultiplier! * 73,
            width: SizeConfig.widthMultiplier! * 384,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(

                    width: 1)),
            child: Center(
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: widget.controller,
                      obscureText: showPassword,
                      validator: widget.validator,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: SizeConfig.widthMultiplier! * 20),
                          border: InputBorder.none),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: SizeConfig.widthMultiplier! * 20),
                    child: GestureDetector(
                        onTap: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        ),
                  )
                ],
              ),
            ),
          ),
          widget.errorText != null                    ? Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              children: [
                SizedBox(
                  width: SizeConfig.widthMultiplier! * 20,
                ),
                Text(
                  widget.errorText.toString(),

                )
              ],
            ),
          )
              : const SizedBox()
        ],
      ),
    )
        : SizedBox(
      width: SizeConfig.widthMultiplier! * 384,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
         ),
          SizedBox(
            height: SizeConfig.heightMultiplier! * 10,
          ),
          Container(
            height: SizeConfig.heightMultiplier! * 73,
            width: SizeConfig.widthMultiplier! * 384,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    width: 1)),
            child: Center(
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      validator: widget.validator,
                      controller: widget.controller,
                      obscureText: widget.obsecureText ?? false,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: SizeConfig.widthMultiplier! * 20),
                          border: InputBorder.none),
                    ),
                  ),
                ],
              ),
            ),
          ),
          widget.errorText != null                    ? Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              children: [
                SizedBox(
                  width: SizeConfig.widthMultiplier! * 20,
                ),
                Text(
                  widget.errorText.toString(),
                )
              ],
            ),
          )
              : const SizedBox()
        ],
      ),
    );
  }
}

class SizeConfig {
  static double? _screenWidth;
  static double? _screenHeight;
  static double _blockSizeHorizontal = 0;
  static double _blockSizeVertical = 0;
  static double? textMultiplier;
  static double? imageSizeMultiplier;
  static double? heightMultiplier;
  static double? widthMultiplier;
  static bool isPortrait = true;
  static bool isMobilePortrait = false;
  void init(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      _screenWidth = constraints.maxWidth;
      _screenHeight = constraints.maxHeight;
      isPortrait = true;
      if (_screenWidth! < 450) {
        isMobilePortrait = true;
      }
    } else {
      _screenWidth = constraints.maxHeight;
      _screenHeight = constraints.maxWidth;
      isPortrait = false;
      isMobilePortrait = false;
    }
    _blockSizeHorizontal = _screenWidth! / 100;
    _blockSizeVertical = _screenHeight! / 100;
    // textMultiplier = _blockSizeVertical / 6.4;
    // imageSizeMultiplier = _blockSizeHorizontal / 3.6;
    // heightMultiplier = _blockSizeVertical / 6.4;
    // widthMultiplier = _blockSizeHorizontal / 3.6;
    textMultiplier = 1;
    imageSizeMultiplier = 1;
    heightMultiplier = 1;
    widthMultiplier = 1;
  }
}