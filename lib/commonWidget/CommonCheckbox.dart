import 'package:flutter/material.dart';

class CommonCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  CommonCheckbox({
    required this.value,
    required this.onChanged,
  });

  @override
  _CommonCheckboxState createState() => _CommonCheckboxState();
}

class _CommonCheckboxState extends State<CommonCheckbox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              width: 24.0,
              height: 24.0,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: widget.value
                  ? Icon(
                      Icons.check,
                      color: Colors.black,
                    )
                  : null,
            ),
            SizedBox(width: 8.0),
            Text(
              '',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
