import 'package:flutter/material.dart';

class SimpleCollectWidgetBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Color(0xffE4E7E8), width: 1))),
      child: Row(
        children: [
          Expanded(
            child: Material(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0)),
                color: Colors.white,
                child: InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 11, 0, 12),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: Color(0xff454F63),
                      ),
                    ))),
          )
        ],
      ),
    );
  }
}
