import 'package:flutter/material.dart';
import 'package:forutonafront/Components/AddressInputSearchBar/AddressInputSearchBar.dart';
import 'package:forutonafront/Components/BackButton/BorderCircleBackButton.dart';

class H008TopSearchBar extends StatelessWidget {

  final String initText;

  const H008TopSearchBar({Key key, this.initText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Color(0xffF2F0F1)))
      ),
      padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Row(
        children: [
          BorderCircleBackButton(),
          SizedBox(width: 16,),
          Expanded(
            child: AddressInputSearchBar(
              readOnly: true,
              autoFocusFlag: false,
              listener: null,
              initText: this.initText,
            ),
          )
        ],
      ),
    );
  }
}
