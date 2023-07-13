import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class SpinnerWidget extends StatelessWidget {
  final List<String> items;
  final Function(String,int) onChanged;
  final String selectedValue;

  SpinnerWidget({
    required this.items,
    required this.onChanged,
    required this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[200],
      ),
      child: DropdownButton<String>(
        value: selectedValue,
        onChanged: (newValue) {
          onChanged(newValue!,items.indexOf(newValue));
        },
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: Colors.black, fontSize: 16),
        underline: SizedBox(), // Remove the default underline
        isExpanded: true,
        dropdownColor: Colors.white,
        items: items.map<DropdownMenuItem<String>>(
              (String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(value),
              ),
            );
          },
        ).toList(),
        icon: Icon(Icons.arrow_drop_down),
      ),
    );
  }
}



