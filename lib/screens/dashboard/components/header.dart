import 'package:adminpannelgrocery/responsive.dart';
import 'package:flutter/material.dart';

import '../../../commonWidget/common_text_field_widget.dart';
import '../../../constants.dart';

class AddCard extends StatelessWidget {
  final Function(bool) onTap;
  final String text;

  const AddCard(this.text, {Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: defaultPadding),
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 3,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.black),
      ),
      child: InkWell(
        onTap: () {
          onTap(true);
        },
        child: Row(
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

class SearchField extends StatefulWidget {
  final String? Function(String?)? textChanged;

  const SearchField({Key? key, required this.textChanged}) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  TextEditingController productname = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
        child: commonTextFieldWidget(
          type: TextInputType.text,
          controller: productname,
          hintText: "Milk",
          secondaryColor: Colors.white,
          labelText: "Search",
          onChanged: (val) {
            widget.textChanged!(val);
          },
        ),
      ),
    );
  }
}
