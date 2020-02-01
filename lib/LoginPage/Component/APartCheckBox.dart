import 'package:flutter/material.dart';

class APartCheckBoxItem {
  bool check = false;
  String text = "";
  Function(bool) onchnage;
  APartCheckBoxItem({this.check, this.text, this.onchnage});
}

class APartCheckBox extends StatefulWidget {
  APartCheckBox({this.item, Key key}) : super(key: key);
  final APartCheckBoxItem item;
  @override
  _APartCheckBoxState createState() {
    return _APartCheckBoxState(item: item);
  }
}

class _APartCheckBoxState extends State<APartCheckBox> {
  APartCheckBoxItem item;
  _APartCheckBoxState({this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        item.check
            ? Container(
                height: 22.00,
                width: 22.00,
                child: FlatButton(
                  child: Container(),
                  onPressed: () {
                    item.onchnage(item.check);
                  },
                  shape: CircleBorder(),
                ),
                decoration: BoxDecoration(
                  color: Color(0xff39f999),
                  border: Border.all(
                    width: 3.00,
                    color: Color(0xff454f63),
                  ),
                  shape: BoxShape.circle,
                ))
            : Container(
                height: 22.00,
                width: 22.00,
                child: FlatButton(
                  child: Container(),
                  onPressed: () {
                    item.check = true;
                    item.onchnage(item.check);
                  },
                  shape: CircleBorder(),
                ),
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  border: Border.all(
                    width: 1.00,
                    color: Color(0xffb1b1b1),
                  ),
                  shape: BoxShape.circle,
                )),
        Container(
          child: Text(item.text,
              style: TextStyle(
                fontFamily: "Noto Sans CJK KR",
                fontSize: 18,
                color: Color(0xff454f63),
              )),
        )
      ],
    );
  }
}
