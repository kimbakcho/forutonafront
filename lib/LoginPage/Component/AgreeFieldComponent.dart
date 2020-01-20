import 'package:flutter/material.dart';

class AgreeFieldItem {
  String text;
  Function onchenge;
  MaterialPageRoute nextpage;
  AgreeFieldItem({this.text, this.onchenge, this.nextpage});
}

class AgreeFieldComponent extends StatefulWidget {
  AgreeFieldComponent({this.fielditem, Key key}) : super(key: key);
  final AgreeFieldItem fielditem;

  @override
  _AgreeFieldComponentState createState() {
    return _AgreeFieldComponentState(fielditem: this.fielditem);
  }
}

class _AgreeFieldComponentState extends State<AgreeFieldComponent> {
  _AgreeFieldComponentState({this.fielditem});
  bool ischecked = false;
  AgreeFieldItem fielditem;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      double top = (constraints.maxHeight / 2) - 20;
      return Container(
          child: Stack(children: <Widget>[
        Positioned(
            left: 16,
            top: top,
            child: Container(
              height: 28,
              width: 28,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ischecked ? Color(0xFF3497FD) : Color(0xFFB1B1B1)),
              child: IconButton(
                  padding: EdgeInsets.all(0),
                  icon: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 26,
                  ),
                  onPressed: () {
                    ischecked = !ischecked;
                    setState(() {});
                  }),
            )),
        Positioned(
          left: 16.0 + 28.0 + 8.0,
          top: top + 5,
          child: Container(
            child: Text(
              this.fielditem.text,
              style: TextStyle(
                fontFamily: 'NotoSansKR',
                fontSize: 14,
              ),
            ),
          ),
        )
      ]));
    });
  }
}
