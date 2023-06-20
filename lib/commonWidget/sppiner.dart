import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class SpinnerWidget extends StatelessWidget {
  final List<String> items;
  final Function(String) onChanged;
  final String selectedValue;

  SpinnerWidget({
    required this.items,
    required this.onChanged,
    required this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButton<String>(
        value: selectedValue,
        onChanged: (newValue) {
          onChanged(newValue!);
        },
        items: items.map<DropdownMenuItem<String>>(
              (String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          },
        ).toList(),
      ),
    );
  }
}



