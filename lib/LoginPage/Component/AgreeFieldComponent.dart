import 'package:flutter/material.dart';

class AgreeFieldItem {
  String text;
  String subtext;
  Function onchenge;
  MaterialPageRoute nextpage;
  bool ischecked = false;
  AgreeFieldItem({this.text, this.onchenge, this.nextpage, this.subtext});
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

  AgreeFieldItem fielditem;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      double top = (constraints.maxHeight / 2) - 15;
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
                  color: this.fielditem.ischecked
                      ? Color(0xFF3497FD)
                      : Color(0xFFB1B1B1)),
              child: IconButton(
                  padding: EdgeInsets.all(0),
                  icon: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 26,
                  ),
                  onPressed: () {
                    this.fielditem.ischecked = !this.fielditem.ischecked;
                    if (this.fielditem.onchenge != null) {
                      this.fielditem.onchenge(this.fielditem.ischecked);
                    }
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
        ),
        this.fielditem.subtext != null
            ? Positioned(
                left: 16.0 + 28.0 + 8.0,
                top: top + 20,
                child: Container(
                    child: Text(this.fielditem.subtext,
                        style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontSize: 10,
                        ))))
            : Container(),
        this.fielditem.nextpage != null
            ? Positioned(
                right: 0.0,
                top: top - 11,
                child: Container(
                    child: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    Navigator.push(context, this.fielditem.nextpage);
                  },
                )),
              )
            : Container()
      ]));
    });
  }
}
