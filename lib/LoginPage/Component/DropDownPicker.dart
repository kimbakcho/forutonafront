import 'package:flutter/material.dart';

class DropDownPicker extends StatefulWidget {
  DropDownPicker({Key key, this.value, this.items, this.onchange})
      : super(key: key);
  List<int> items;
  int value;
  Function onchange;
  @override
  _DropDownPickerState createState() => _DropDownPickerState();
}

class _DropDownPickerState extends State<DropDownPicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
        decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<int>(
              value: this.widget.value,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              onChanged: (int newValue) {
                setState(() {
                  this.widget.value = newValue;
                  this.widget.onchange(newValue);
                });
              },
              items: this.widget.items.map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList()),
        ));
  }
}
