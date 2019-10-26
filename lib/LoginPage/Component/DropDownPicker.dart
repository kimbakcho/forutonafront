import 'package:flutter/material.dart';

class DropDwonPickerItem {
  List<int> items;
  Function onchange;
  int value;
  DropDwonPickerItem({this.items, this.onchange, this.value});
}

class DropDownPicker extends StatefulWidget {
  final DropDwonPickerItem items;
  DropDownPicker({Key key, this.items}) : super(key: key);

  @override
  _DropDownPickerState createState() {
    return _DropDownPickerState(items);
  }
}

class _DropDownPickerState extends State<DropDownPicker> {
  DropDwonPickerItem items;
  _DropDownPickerState(this.items);

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
              value: items.value,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              onChanged: (int newValue) {
                setState(() {
                  items.value = newValue;
                  items.onchange(newValue);
                });
              },
              items: items.items.map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList()),
        ));
  }
}
