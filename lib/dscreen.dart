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
      appBar: AppBar(title: Text("Dash board screen"),),
    );
  }
}
